import pyautogui

def enter_value_for_last():
    pyautogui.keyDown('ctrl')
    pyautogui.press('a')
    pyautogui.keyUp('ctrl')
    pyautogui.press('DELETE')
    pyautogui.write('490000')
    pyautogui.press('enter')