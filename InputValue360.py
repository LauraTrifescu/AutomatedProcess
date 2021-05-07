import pyautogui

def enter_period():
    pyautogui.keyDown('ctrl')
    pyautogui.press('a')
    pyautogui.keyUp('ctrl')
    pyautogui.press('DELETE')
    pyautogui.write('360')
    pyautogui.press('enter')