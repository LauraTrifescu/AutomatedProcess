import pyautogui

def enter_value_for_first():
    pyautogui.keyDown('ctrl')
    pyautogui.press('a')
    pyautogui.keyUp('ctrl')
    pyautogui.press('DELETE')
    pyautogui.write('390000')
    pyautogui.press('enter')