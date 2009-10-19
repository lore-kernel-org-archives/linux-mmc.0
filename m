From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Sun, 18 Oct 2009 18:17:35 -0600
Message-ID: <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <4AD81DC2.4080607@googlemail.com>
	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>
	 <4AD8C959.1000004@googlemail.com>
	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
	 <4ADB4604.2090704@googlemail.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:62814 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZJSARa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Oct 2009 20:17:30 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <sakoman@gmail.com>

Richard,

MMCHS_CON.CPTL =3D 1  < Don't disable input buffer on DAT1 after
completion to allow seeing SDIO interrupt>

Sounds exactly like what we need.

Thanks
John

On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti.com>=
 wrote:
>
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>> Sent: Sunday, October 18, 2009 11:45 AM
>
>> > It would be funny if the TRM was wrong and the CIRQ bit is really
>> > cleared by writing 1 to it. =A0I'll try that.
>
> A while back I hunted down a few of the bits for this. =A0Maybe this =
will help some.
>
> SYSCONFIG.ENAWAKEUP =3D 1 < allow ocp wrapper to generate an interrup=
t to prcm>
> MMCHS_HCTL.IWE =3D 1 < route wake up to module ocp wrapper>
> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 after co=
mpletion to allow seeing SDIO interrupt>
> MMCHS_HCTL.IWE
> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
> MMCHS_STAT<bit to write for clear of SDIO interrupt>
> CCCCR - IRQ_ENABLE (think host stack will do this)
>
> Regards,
> Richard W.
>
