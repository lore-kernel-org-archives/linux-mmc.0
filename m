From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded
	irq handler
Date: Thu, 20 Feb 2014 10:59:03 +0000
Message-ID: <20140220105903.GY21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk> <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk> <20140218175703.GJ21483@n2100.arm.linux.org.uk> <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com> <20140219094322.GR21483@n2100.arm.linux.org.uk> <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com> <20140219095212.GT21483@n2100.arm.linux.org.uk> <CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com> <20140219105011.GU21483@n2100.arm.linux.org.uk> <CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43972 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753013AbaBTK7Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2014 05:59:16 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On Wed, Feb 19, 2014 at 04:25:12PM +0530, Viresh Kumar wrote:
> Absolutely, it will work.
> 
> Thanks for your efforts in cleaning up this stuff..

I'll send a few patches in a moment.  First through, I've just found this
gem:

static int sdhci_probe(struct platform_device *pdev)
{
...
        sdhci = devm_kzalloc(&pdev->dev, sizeof(*sdhci), GFP_KERNEL);
...
        if (np) {
...
        } else {
                sdhci->data = dev_get_platdata(&pdev->dev);
        }

        pdev->dev.platform_data = sdhci;
...
	... some paths which can cause probe to return an error code ...
...
static int sdhci_remove(struct platform_device *pdev)
{
        struct sdhci_host *host = platform_get_drvdata(pdev);
        struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
...
        clk_disable_unprepare(sdhci->clk);
        clk_put(sdhci->clk);

So, what happens if we hit an error such as -EPROBEDEFER after that
assignment to pdev->dev.platform_data, and then re-probe the driver
later?

This is just horribly broken.

What's wrong with using the facilities in sdhci to allow you to have
your own private data after the sdhci_host structure?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
