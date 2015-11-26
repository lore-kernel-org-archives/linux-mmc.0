From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci at91: add PM support
Date: Thu, 26 Nov 2015 17:24:40 +0100
Message-ID: <CAPDyKFpShib_OsB6HB7_5PNEkkMpWq6+LwaD0-AH=QqhzpOB3A@mail.gmail.com>
References: <1447151810-21864-1-git-send-email-ludovic.desroches@atmel.com>
	<CAPDyKFoAwmkw0D8QbA4UV3uhhNS7hmfOiRv3ZUhMp8uoxzWnrw@mail.gmail.com>
	<20151126160718.GE8908@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151126160718.GE8908@odux.rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

On 26 November 2015 at 17:07, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Tue, Nov 10, 2015 at 12:12:30PM +0100, Ulf Hansson wrote:
>> On 10 November 2015 at 11:36, Ludovic Desroches
>> <ludovic.desroches@atmel.com> wrote:
>> > Add runtime PM support and use runtime_force_suspend|resume() for system
>> > PM.
>> >
>
> [...]
>
>> >  static int sdhci_at91_probe(struct platform_device *pdev)
>> >  {
>> >         const struct of_device_id       *match;
>> > @@ -148,6 +206,11 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>> >         if (ret)
>> >                 goto clocks_disable_unprepare;
>> >
>> > +       pm_runtime_set_active(&pdev->dev);
>> > +       pm_runtime_enable(&pdev->dev);
>> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>> > +       pm_runtime_use_autosuspend(&pdev->dev);
>>
>> Move these four runtime PM calls above sdhci_add_host(), as after that
>> point the host is used and thus runtime PM operations starts.
>
> Sadly I have discovered a bit late it is not working when doing this
> because the controller has been suspended before doing the
> sdhci_add_host().
>
> What is the right way to fix it? Calling pm_runtime_get_noresume()

I would do that before pm_runtime_enable().

> before sdhci_add_host() and calling pm_runtime_put_autosuspend() after?

Yes. Sorry for not spotting this before.

[...]

Kind regards
Uffe
