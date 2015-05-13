From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3, 2/6] mmc: sdhci-pltfm: support both LE and BE mode for SDHCI platform
Date: Wed, 13 May 2015 13:19:04 +0200
Message-ID: <CAPDyKFq6ELTakvscMVWfG=0pscLuN-bB47FGmjh1eTv5A+_1NQ@mail.gmail.com>
References: <1431067818-41378-1-git-send-email-yangbo.lu@freescale.com>
	<2093374.CPZJl41Uyy@wuerfel>
	<BY1PR0301MB1192096115DF67131BBE7BA1F2DB0@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFr=1Yh9hgAV5b3To1ZCjkaG_+xbcwRByRkptZvoEfrM9Q@mail.gmail.com>
	<BY1PR0301MB1192FEF44307B98995292CCDF2DA0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34095 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933792AbbEMLTF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 07:19:05 -0400
Received: by qgfi89 with SMTP id i89so19312081qgf.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2015 04:19:04 -0700 (PDT)
In-Reply-To: <BY1PR0301MB1192FEF44307B98995292CCDF2DA0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>

On 12 May 2015 at 11:53, Lu Y.B. <yangbo.lu@freescale.com> wrote:
> Thanks Uffe.
> I also think checking every time is not better idea but am not so clear about your method.
> I think the plan you wanting should be one of the bellowing, which one is the plan you want?
> Plan 1,
> Define sdhci_be32bs_readl for big-endian
> Define sdhci_le32bs_readl for little-endian
> Define a function pointer sdhci_32bs_readl to be assigned when checking endian mode in probe.

No, thanks.

> Plan 2,
> For esdhc,
> Define struct sdhci_ops sdhci_esdhc_ops_1 for big-endian
> Define struct sdhci_ops sdhci_esdhc_ops_2 for little-endian
> Define struct sdhci_ops sdhci_esdhc_ops to be assigned when checking endian mode in probe.

This is what I had in mind.

Though I now realize that it then doesn't make sense to extend the
common MMC DT parser, mmc_of_parse(), to fetch the endian mode.

That's because the endian mode needs to be known to pick the correct
sdhci_ops, which is the parameter you provide to sdhci_pltfm_init().

Forgive me for pushing you back an forth. So, yes I like you to
implement plan2 and thus patch1 should only update the documentation
of the DT bindings.

Kind regards
Uffe
