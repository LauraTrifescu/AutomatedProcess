import pyautogui

def enter_value_for_second():
    pyautogui.keyDown('ctrl')
    pyautogui.press('a')
    pyautogui.keyUp('ctrl')
    pyautogui.press('DELETE')
    pyautogui.write('440000')
    pyautogui.press('enter')