Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98B13A3F7;
	Fri, 26 Jul 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999772; cv=none; b=SPlwV1I9ifYOhaWYsgCq49jC07PHgX5DfjqgvQkhpElAoSOTau1oIyJIWh6WWd+I2IyLGSPJ9kdalTCYjhtIqS3gnL739Ja8sr5usBIpl+CJmw8MI3lzxc8PIETQfIW4c/dI1kH5XPX8yIZceCdvTv3WUJYapLrfF26ciGGlkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999772; c=relaxed/simple;
	bh=7rnOQsXWMQ8UjsklPiSOfWLaziMmc0aWK2YMvDmOO3g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nRpny21mV70+OCRRnV7r2DOqfcpCFdUuys5w46Jqz3Vn16li3TY1SnupV6nEODQVGxbGuq2ozvohqR8ho82Nfnh5a8RtPDSgPTOYN04xN0E030xk7p6SYC1H87uMOpFwKW6tNoD5+zWDnMyAaUWt6tChyrbnEz7pIsB2EGn5bg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cRaeqQwA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cRaeqQwA"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46QDFh9R2569478, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721999743; bh=7rnOQsXWMQ8UjsklPiSOfWLaziMmc0aWK2YMvDmOO3g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cRaeqQwAw3ipM5vVy/WSm4u6UNDKSxqlWVe9UR59hyawXmS0q98lr3Q10hiSN1Ez0
	 bKQ7bcN4BoKNGDI3hrbmYbe1AA9E2ckTOyl7vbcWzLakSeVvTXaS8Qm8jX62vlQFTB
	 pXCFd5zwVKKWYuEfK/1ahvL2IWimRmEAPYOXPrBt1MZzSjkNeCSN/yHGqEVLRoANtZ
	 lUkWsyxArHnyvbHMM5vf8uGk/A3b2ZyX2BJPwNe0Bj+txy2jeDFpGVjL9iesYBD/pl
	 XqkWm+m09wZEUIeEm+/fFAfpH7P6Vl0TY7R25JDjuT/lvk7LJ2cQHJQ1ByjopLlcOK
	 a9Q6lz2exAsUg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46QDFh9R2569478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 21:15:43 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 21:15:44 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jul 2024 21:15:43 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38]) by
 RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38%5]) with mapi id
 15.01.2507.035; Fri, 26 Jul 2024 21:15:43 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ricardo@marliere.net"
	<ricardo@marliere.net>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH 0/4] Add support SDUC for Realtek card readers
Thread-Topic: [PATCH 0/4] Add support SDUC for Realtek card readers
Thread-Index: AQHa2Z0rVxamUGlCx0OwfDDJuTfD97IIDJgAgAD42gA=
Date: Fri, 26 Jul 2024 13:15:43 +0000
Message-ID: <9e73388ac2ca40fbb31ad2c3c7a09ced@realtek.com>
References: <20240719053314.1636649-1-ricky_wu@realtek.com>
 <DM6PR04MB657501EF884BAAC24446E8A1FCB42@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657501EF884BAAC24446E8A1FCB42@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ulf, Gregkh and Arnd

Please withdraw this patches.
I am cooperating with Avri and will have a new patch for SDUC.
It will more readable, complete and suitable for mmc

Ricky

> -----Original Message-----
> From: Avri Altman <Avri.Altman@wdc.com>
> Sent: Friday, July 26, 2024 2:14 PM
> To: Ricky WU <ricky_wu@realtek.com>; ulf.hansson@linaro.org;
> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> ricardo@marliere.net; gregkh@linuxfoundation.org; arnd@arndb.de
> Subject: RE: [PATCH 0/4] Add support SDUC for Realtek card readers
>=20
>=20
> External mail.
>=20
>=20
>=20
> Hi,
> > Summary:
> > this patch is for mmc to support SDUC(Secure Digital Ultra Capacity)
> > and add Realtek Cardreaders to support it
> >
> > About SDUC:
> > SDUC is defined in SD7.0 spec, it support the max capacity is 128TB[1]
> >
> > Roughly implemented functions by this patch:
> > 1.Mutual identification of SDUC in ACMD41 initialization (5.2.1[2])
> > 2.SDUC card user area capacity calculation (5.2.2[2]) 3.Memory
> > read/write commands sequence (5.2.3[2]) 4.Erase Commands Sequence
> > (5.2.4[2])
> >
> > patches:
> > patch#1: Defined functions and modified some type of parameter
> > patch#2: For mmc to support SDUC
> > patch#3: Add Realtek sdmmc host to support SDUC
> > patch#4: Add Realtek card readers to support SDUC
> I think that the way you organized your code makes it very hard to review=
.
> I would like to propose rearranging your code in a more readable form.
> E.g. something like:
>=20
> 1) mmc: sd: SDUC Support Recognition:
> Explain how ACMD21 was extended to support the host-card handshake during
> initialization.
> Also, make it clear, e.g. in your commit log that if a SDUC card is inser=
ted to a
> non-supporting host, it will never respond to this ACMD21 until eventuall=
y, the
> host will timed out and give up.
>=20
> 2) mmc: sd: Add SD CSD version 3.0
> Add here the require changes in core/bus.c, core/card.h, and csd ver 3 in
> mmc_decode_csd().
>=20
> 3) mmc: sd: Add Extension memory addressing Add in core/sd_ops.c
> mmc_send_ext_addr() so you'll be able to call it in open-ended rw, erase,=
 etc.
> Here it's a good place to explain the general idea of the new CMD22.
>=20
> 4) mmc: core: Add open-ended Ext memory addressing Call
> mmc_send_ext_addr() for open-ended rw
>=20
> 5) mmc: host: Always use manual-cmd23 in SDUC
> 6) mmc: core: Add close-ended Ext memory addressing
> 7) mmc: host: Add close-ended Ext memory addressing Those 3 patches will
> facilitate close-ended rw.
> It should be IMO or any SDHCI and not just for RealTk's.
> Once the driver is in place, SDUC support doesn't require specific hw
> characteristics from the host controller.
>=20
> 8) mmc: core: Add Ext memory addressing for erase
> 9) mmc: core: Allow mmc erase to carry large addresses Make the require
> changes to support erase
>=20
> 10) mmc: core: Adjust ACMD22 to SDUC
> Make the adjustments in ACMD22.
>=20
> I also think that there are some specific issues with your implementation=
, But it
> would be easier to discuss those once the patches are in a more readable
> form.
>=20
> Thanks,
> Avri
>=20
>=20
> >
> > Reference:
> > [1] SD Specifications Part 1 Physical Layer Specification Version 7.00
> > [2] SD Specifications SDUC Host Implementation Guideline Version 1.00
> >
> > Ricky Wu(4):
> >  mmc: core: some definitions and type modifications for SDUC
> >  mmc: core: add SDUC init rw erase flow to mmc
> >  mmc: rtsx: make Realtek sdmmc to support SDUC
> >  misc: rtsx: add Realtek card readers to support SDUC
> >
> >  drivers/misc/cardreader/rts5227.c |  1 +
> > drivers/misc/cardreader/rts5228.c |  1 +
> > drivers/misc/cardreader/rts5249.c |  1 +
> > drivers/misc/cardreader/rts5260.c |  1 +
> > drivers/misc/cardreader/rts5261.c |  1 +
> > drivers/misc/cardreader/rts5264.c |  2 +-
> >  drivers/mmc/core/block.c          | 13 +++++++--
> >  drivers/mmc/core/bus.c            |  4 ++-
> >  drivers/mmc/core/card.h           |  3 ++
> >  drivers/mmc/core/core.c           | 38 +++++++++++++++++--------
> >  drivers/mmc/core/core.h           |  6 ++--
> >  drivers/mmc/core/host.h           |  5 ++++
> >  drivers/mmc/core/queue.h          |  1 +
> >  drivers/mmc/core/sd.c             | 47
> +++++++++++++++++++++++++++++++
> >  drivers/mmc/host/rtsx_pci_sdmmc.c |  6 ++++
> >  include/linux/mmc/card.h          |  2 +-
> >  include/linux/mmc/core.h          |  1 +
> >  include/linux/mmc/host.h          |  1 +
> >  include/linux/mmc/sd.h            |  5 ++++
> >  include/linux/rtsx_pci.h          |  1 +
> >  20 files changed, 121 insertions(+), 19 deletions(-)
> >
> >
> > --
> > 2.25.1

