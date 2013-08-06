From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/4] mmc: dw_mmc: Add exynos resume_noirq callback to
 clear WAKEUP_INT
Date: Tue, 6 Aug 2013 15:09:46 -0700
Message-ID: <CAD=FV=W3kxkwHGoWE5YsztW7NNOYQCy6yFwNJQDaTFx=58cgbA@mail.gmail.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
	<1375825071-20922-1-git-send-email-dianders@chromium.org>
	<1375825071-20922-3-git-send-email-dianders@chromium.org>
	<19655139.gpQFe0oLNI@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <19655139.gpQFe0oLNI@flatron>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Tomasz,

On Tue, Aug 6, 2013 at 2:58 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> +static int dw_mci_exynos_resume_noirq(struct device *dev)
>> +{
>> +     struct dw_mci *host = dev_get_drvdata(dev);
>> +     u32 clksel;
>> +
>> +     clksel = mci_readl(host, CLKSEL);
>> +     if (clksel & SDMMC_CLKSEL_WAKEUP_INT)
>> +             mci_writel(host, CLKSEL, clksel);
>
> What about clock gating? Will the clock used for clocking this register be
> always enabled when this gets called?

Since this is just accessing and writing a register in the "Mobile
Storage Host" block, I'd imagine that this should be the "biu" (bus
interface unit) clock, right?  The dw_mmc code grabs the biu clock at
probe time and never lets it go.  That means that we're OK as long as
common clock framework has already restored clocks to normal operation
by this time.

Do you think that common clock framework might not have put the clocks
back into order by the time "noirq" callbacks are executed?

-Doug
