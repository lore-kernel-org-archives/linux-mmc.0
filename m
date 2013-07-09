From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 2/5] mmc: dw_mmc: Add suspend/resume callbacks; disable
 irq during suspend
Date: Tue, 9 Jul 2013 22:17:51 +0100
Message-ID: <CAAG0J9_FbJYRrR=8GgHCvMDSbwfwXic81TJfchnv5UM798RB_g@mail.gmail.com>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
	<1373391071-6312-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373391071-6312-3-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

On 9 July 2013 18:31, Doug Anderson <dianders@chromium.org> wrote:
> On some platforms (like exynos5420) the dw_mmc controller may be in a
> strange state after we wake up from sleep.  Add callbacks to allow for
> dealing with these quirks.  Prevent interrupts from firing when we're
> suspended since this strange state may cause interrupts to fire.
>
> In my case I saw the WAKEUP_INT interrupt firing upon resume and
> needed to add some code to handle this.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Would it make sense to take advantage of the {suspend,resume}_noirq
power management callbacks to clear that WAKEUP_INT before interrupts
are re-enabled, rather than explicitly disabling and enabling the
interrupt at the suspend/resume stage?

Cheers
James
