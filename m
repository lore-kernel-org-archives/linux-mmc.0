From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Thu, 20 Feb 2014 16:48:58 +0530
Message-ID: <CAKohpo=FTk9SGCMJGBdOUheUg71WsG7qaeE9rwQRqd5dP4O8FQ@mail.gmail.com>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
	<E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
	<20140218175703.GJ21483@n2100.arm.linux.org.uk>
	<CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
	<20140219094322.GR21483@n2100.arm.linux.org.uk>
	<CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
	<20140219095212.GT21483@n2100.arm.linux.org.uk>
	<CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com>
	<20140219105011.GU21483@n2100.arm.linux.org.uk>
	<CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com>
	<20140220105903.GY21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45925 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbaBTLTA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2014 06:19:00 -0500
Received: by mail-ob0-f173.google.com with SMTP id uz6so1911185obc.32
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2014 03:18:58 -0800 (PST)
In-Reply-To: <20140220105903.GY21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On 20 February 2014 16:29, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> I'll send a few patches in a moment.  First through, I've just found this
> gem:

Yeah, 'gem' is the real word for this precious code :)

> static int sdhci_probe(struct platform_device *pdev)
> {
> ...
>         sdhci = devm_kzalloc(&pdev->dev, sizeof(*sdhci), GFP_KERNEL);
> ...
>         if (np) {
> ...
>         } else {
>                 sdhci->data = dev_get_platdata(&pdev->dev);
>         }
>
>         pdev->dev.platform_data = sdhci;
> ...
>         ... some paths which can cause probe to return an error code ...
> ...
> static int sdhci_remove(struct platform_device *pdev)
> {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
> ...
>         clk_disable_unprepare(sdhci->clk);
>         clk_put(sdhci->clk);
>
> So, what happens if we hit an error such as -EPROBEDEFER after that
> assignment to pdev->dev.platform_data, and then re-probe the driver
> later?

BANG BANG!! :)

> This is just horribly broken.
>
> What's wrong with using the facilities in sdhci to allow you to have
> your own private data after the sdhci_host structure?

Nothing wrong in that, only right.. Do you want me to float a patch for
this or you can get that done along with your series?

Thanks again..

--
viresh
