From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2.6.32]: Add new device IDs and registers forMULTIMEDIA
	CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Thu, 18 Nov 2010 04:15:59 +0000
Message-ID: <20101118041559.GE23555@void.printf.net>
References: <FC57104DF444434A9D1D8A7B4EBB292307D13E8A@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60127 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713Ab0KREQB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 23:16:01 -0500
Content-Disposition: inline
In-Reply-To: <FC57104DF444434A9D1D8A7B4EBB292307D13E8A@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Cc: linux-mmc@vger.kernel.org, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>, Rezwanul_Kabir@Dell.com, "Shirley Her (SC)" <shirley.her@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "William Lian (TP)" <William.Lian@o2micro.com>

Hi Jennifer,

This is looking better, thanks -- just a few more questions:

On Tue, Nov 16, 2010 at 02:05:16PM +0800, Jennifer Li (TP) wrote:
> Root cause:
> O2Micro's ADMA and related functions can't work by default Linux SD
> driver. We need mark those related registers.

If the goal is to disable ADMA, have you tried using the BROKEN_ADMA
quirk?  Like this:

static const struct sdhci_pci_fixes sdhci_o2 = {
        .probe          = o2_probe,
        .quirks         = SDHCI_QUIRK_BROKEN_ADMA,
};

If you do this, do you still need to perform the PCI writes?

> +		ret = pci_read_config_byte(chip->pdev, O2_SDMMC_MULTI_VCC3V, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch = 0x08;
> +		ret = pci_write_config_byte(chip->pdev, O2_SDMMC_MULTI_VCC3V, scratch);

Here you read in a value to scratch, but then you go ahead and write
0x08 to the register regardless.  We can skip the read here, right?

> +		ret = pci_read_config_byte(chip->pdev, O2_SDMMC_CAPABILITIES, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch |= 0x01;
> +		ret = pci_write_config_byte(chip->pdev, O2_SDMMC_CAPABILITIES, scratch);
> +
> +		ret = pci_read_config_byte(chip->pdev, O2_SDMMC_CAPABILITIES, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch = 0x73;
> +		ret = pci_write_config_byte(chip->pdev, O2_SDMMC_CAPABILITIES, scratch);

Here you write a value to O2_SDMMC_CAPABILITIES that's dependent on the
read value, but then after that you immediately overwrite the register
with 0x73 regardless of what was in it before.  Why perform the first
read-and-write cycle and the second read, if you're just going to write
0x73 in the end?

> +
> +		ret = pci_read_config_byte(chip->pdev, O2_SDMMC_ADMA1, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch = 0x39;
> +		ret = pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA1, scratch);
> +
> +		ret = pci_read_config_byte(chip->pdev, O2_SDMMC_ADMA2, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch = 0x08;
> +		ret = pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA2, scratch);

Same as above -- if the write isn't dependent on the read, I don't see
why to bother with the read.  Also, you can avoid assigning the return
value of pci_write_config_byte() to "ret" now that we aren't testing that.

> Signed-off-by: Jennifer Li Developer <Jennifer.li@o2micro.com>

I don't think "Developer" should be here, since the text should just be
your name.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
