From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/5] mmc: dw_mmc: Add suspend_noirq/resume_noirq
 callbacks for dw_mmc-pltfm
Date: Wed, 10 Jul 2013 08:08:28 -0700
Message-ID: <CAD=FV=VmWHfM-Y5O41hwH7kbXR7QpitgCcD9R4g8V-Tqr0fiog@mail.gmail.com>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
	<1373411961-23812-1-git-send-email-dianders@chromium.org>
	<1373411961-23812-3-git-send-email-dianders@chromium.org>
	<51DD1D46.2000001@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51DD1D46.2000001@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

James,

On Wed, Jul 10, 2013 at 1:37 AM, James Hogan <james.hogan@imgtec.com> wrote:
>> -SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
>> +const struct dev_pm_ops dw_mci_pltfm_pmops = {
>> +     SET_SYSTEM_SLEEP_PM_OPS(dw_mci_pltfm_suspend, dw_mci_pltfm_resume)
>> +     .suspend_noirq = dw_mci_pltfm_suspend_noirq,
>> +     .resume_noirq = dw_mci_pltfm_resume_noirq,
>> +};
>
> Does Exynos support hibernation? I see that SET_SYSTEM_SLEEP_PM_OPS sets
> freeze, thaw, poweroff, and restore callbacks too. You may not need the
> hibernation specific _noirq callbacks though in which case it's probably
> fine as it is.

Thank you for your review and good suggestions.  You're right that I
should add the other "noirq" variants in here.  Even if hibernation
isn't supported now that's the right thing to do.  I will fix that and
send v3 with your "Reviewed-by".


-Doug
