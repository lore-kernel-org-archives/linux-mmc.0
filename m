Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.88.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400066;
	b=UckH65lNWWp0AJB79rXSpdmjGJ6yMS0bC3l0bOfr9MExKbqmJmZAs92+V4jJOFp883g8
	 J8AWkUcDmJGF17Gg1iwjNNH4pdsXnSBJ0qL00URxWjXMlBXZ1xBAI284SOM6//BrsI9pg
	 QXeujhO4x19+kG8E413nKGmK1bfhMo69qksXhrj20IYM57t3v5etl/jSaSxxHBAnfQPtF
	 Dk5FJV8Hg3lURkUYCy2aUzUq7t1aUqR2lmLgmphgB5xgGuvi3S+ATFErTtFGog/8bv2Jn
	 tf05JIJ4wQTsK7+U3QC4+xl2DrgRvxSlyIqGFYr8o62fmr4DAWfiXI1tO+xHyyvwblA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400066;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Info-Out:X-JNJ;
	bh=0gIgGhCHm8bEpsZOPji4A4j+l9vAgID+Kd1kyXON6Fw=;
	b=lPat+70NXHIKAL24BOfTND50XeDHl7Rjdg+ym0oyKWbxl1/4dl0RN8SACNPZ8m4UdbpB
	 njx2b1KdQzQLj/JYBXI5ncBU0MBXOA4ZO3q7J8DN51YZoWtoUAqqUaqxmhH+SZFEWDFcB
	 9FnbKLeV3s8y4uUwVDjfJ4cbItlf5AbSJwGwixQol2+s7F+h8uQqyV99cjHh9zD6XY3O2
	 +CD+MPd4zhu4Z/XRtKr+wkXpaqGu5SQL75l8Qr84s/XOEd2GOHKw7cjBlHq4NeJpDaj43
	 wUrIPERrWMLD5ESjxdGePI1EwFh7PNrzSbbmJHYDPpaAyUq8G1Ou+qpXp4tbez4lWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=manyhobbies.com;
	spf=pass smtp.mailfrom=manyhobbies.com;
	dkim=pass header.d=manyhobbies.com header.i=@manyhobbies.com header.a=rsa-sha256 header.s=sig1 header.b=Bb9kCZHQ;
	arc=none smtp.remote-ip=57.103.88.75
Received: from outbound.ci.icloud.com (ci-2007h-snip4-2.eps.apple.com [57.103.88.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD05606A321
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 22:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD05606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manyhobbies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manyhobbies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=manyhobbies.com header.i=@manyhobbies.com header.a=rsa-sha256 header.s=sig1 header.b=Bb9kCZHQ
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPS id 446D718000B1;
	Fri, 30 Oct 2026 22:41:03 +0000 (UTC)
X-ICL-RepId: 01a18ef9-450e-7640-aed8-000f5f985d83
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAUMGWQZeD04dXwVcEhVdRUcMWkVWH3kVUgNOA10SWxFWHhkIXR0ZHldQWgpcCVEXUQ9eDkFeWhdeTUUID0kZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1UGV0UXwRQElAdQENUBF9QVBFXUAsocTYMO3AuBUYAMwA+HllyXnNdAU0GXRopCjMPTHApAC0GQA04XgxZElofWxpaCERFUR9URhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manyhobbies.com; s=sig1; t=1793400064; x=1824936064; bh=0gIgGhCHm8bEpsZOPji4A4j+l9vAgID+Kd1kyXON6Fw=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=Bb9kCZHQkDTpCT4NLupg0Nl2OgKCSvH2HMsm0YGsmIaB/Zz0dEyiXaP0YsC87la0qc3id6w6Si4xjIurKXeIurx5cXWJWAxu4DQBD2anGgmyqBQ/e8OAwy8U4n0bY+fmgZ/LGWe4HU32lCSod4kJdFMMAUDGnRhL5cNAtPiRRI14++vsCrEwGEiFnaKqYsD+RGG3STsjYtiS1E6vRdFhJ1G/lSdJIMp/TTyl9fZ+cSJduiIAOePszbnuc4oEVIcMauvPzURSxvB7m9fiXJtqJMPatfIaNmUu5VfMy5bJQDC9KJkx7PptTb6cwSp3RCk39C6PYfi/UviBpp93PuoW2Q==
mail-alias-created-date: 1780273699991
Received: from smtpclient.apple (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPSA id 47F5918000F2;
	Fri, 30 Oct 2026 22:41:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v3] mmc: sunxi: reset the controller after an update-clock
 timeout
From: tam.do@manyhobbies.com
In-Reply-To: <CAPx+jO_VxJctXCZMVdzeq4CX-Ru7ACM6=wQ7GMdG2+4F1pOcBQ@mail.gmail.com>
Date: Fri, 30 Oct 2026 17:40:50 -0500
Cc: Ulf Hansson <ulfh@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 linux-mmc@vger.kernel.org,
 linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCF5CCC2-2C9F-4E5A-8550-B8C64CD7F404@manyhobbies.com>
References: <179318778660.81375.11263258280496155344@manyhobbies.com>
 <CAPx+jO_VxJctXCZMVdzeq4CX-Ru7ACM6=wQ7GMdG2+4F1pOcBQ@mail.gmail.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA5MCBTYWx0ZWRfX6ZPq8saZmVS9
 zjMsokeOMCKdmu/yQcC4V22sWlQyQ1HBzSKRhK1fiDzb60xvxLo4cL9mKRhhDmCyrB2mIqbd7x0
 uKuAL2nbM2vqtIR9mGadjX0KtO1igR+LD6b/I0+OIzm0q2hWmvacQNoE78F6qENsANFo7ISoSF1
 sUPhBriG0HXhoin1X0CuIRAmVlk8gPDrWx4q5IXyy8MYiqefInEvL4V0fxP1asNHaOR7LDnjzTg
 6XIPTcJ4cBPiV3wqPztUxm/QSEqlIbdDjN/Pp+Fnyty+3FwYB/RHFDmp+/qirRP77hb6hHlQRil
 Po7NecTH3M+tj8iN1iAhaQcPta/8vimTUGn7SSh7IXhp/GHXBDG8rwCn+xX8xk=
X-Proofpoint-ORIG-GUID: d-g_JzEoDafdOghAXArm5o5J2zjxV5Dp
X-Proofpoint-GUID: d-g_JzEoDafdOghAXArm5o5J2zjxV5Dp
X-Authority-Info-Out: v=2.4 cv=ee4wvrEH c=1 sm=1 tr=0 ts=6ae51d00
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w2OPf45SAAAA:8 a=EUspDBNiAAAA:8
 a=hnEzuQZJkBTHcMNEFcUA:9 a=QEXdDO2ut3YA:10 a=-iXIJKm6ftRzmWoHelNS:22
X-JNJ: AAAAAAAB5wpPft3t5Hb03TsFJ5Ba3F5dLiFoNSr9VU9fEJmEtezYo9WH+ErJMKOYCLru+I
 mz2rhphs11lhcdsXcBtEkV4SskrwMzuCq2CD1IAa+FcBKjf3scviT5u4IJALB+bPkyeVRK
 3o8YYcMmoEG5hTVWNv2oU16FVyUkoEiT/OCqDKun5i3Dmh5dPKx/n/CRpyNz+TkMgsJFEn
 4/A2NKEt6Jg6qCxCgXuG3MKptL6EWx06Dhl2uik7dcMOH7D1GmGuaylU8qTxIVibIYm4cq
 r9YdJPwwaVj01gVc494Ca0poE9Gw3CihewjhQLaVewZSBnkSs6vGqmY2rlCqhQAgNnkA8o
 IXYjV6reAoWmO3Gsb3Fc9+1kBl2yVUq+REh4nFeJpDuUtcpaDWaPvt+2smNpGlbUZ6mfSv
 140HWV5WOPl6UyYr/ZYOkn/rEdQ9RwAX9zU1Gm3uwlhD2LRO5fqDxz6dQVYNVVG3b9vjWp
 S0jJzveEjS1/tgF/SN/TgFgvibF2q7tViuUYs1U63gNCbyVMD6z8bAbghgODjKmCRtEnJ3
 kIeAEg0VqbBEOYzYTrnSAPrASA9zxM+ZII9gTbHIRibI5ISIIj+XnmbFO2hREg4R92Y+NA
 6Z356uDavtb0AGlhVJVY9ExW13annMBlKM4dc+ug6urrdjIxj4Sjdd8O9MAmTUtUcd7u6e
 pCLsoCoPFY5AK486BJuxDLpWxbi48zTWjdzxrszn/u7LGDcjJ6ty8npBFMKKrFUpV6Er2W
 MXAv1XTKwp6VVYSnvGOIe8Am4IsBCIGNxtWje4SW9nbpEyuXVgQwC3uGnu6vTcQHxpXFyo
 pJ26Tzh3152RZi3J2TAWBcXXbmxcr/QdmFpLLdO+rqM0HpkzIzZQHHlJ+0H2wf3NGlVu4u
 LbL3qU4SHjsdqBJrV7mYRMIJT9Ud+su7Gp+zYioGvatWUGL7TdHR1tX326EtJe6GciT1o2
 B7Bj70l2+UGCApZRwf6SD+0hMeHACbxD9BjheU74GlbGkritNCOVrvhB7wZhjLzhY9BqHZ
 kbHcqhn6PLPafdQ32umRG9RatxvIBv5iDKAd8O4WVZkpCr8Qq5Z7TCebWc2v+XRXQg8/7I
 bB9vBLrGJS7IJTLBYshuN2G7s6B8gpktuY0rBwtLsN3POI6yq9jn2oIz/0AEe5Vg+lJAq5
 dFD6tN5LfkMSsowGbM9dQVeF60KhyS+bblEcdOtzHYz/Ryq4hhJxW14WhbJ7kxV70/EsxH
 Ahf/A6Otwo6I7KnGMCrV6KtsqvDRae569WW/sNUHTWzT5MpbyV7lCsmvoZbPtaPyG2iVl1
 Fh/HQXrqnr8BP41gFhaBEya5V/UdlJBu9T6x2hXPHrgILP0C15RZHNKBzmm2aT/UnmH8n5
 UP7chtADnkiwdeKNQXAOPEhoZ5Vi61pKW03+tz0G5+KfWjLdTLwcbPIuWJmZHYhFQuOhPS
 SL7HrzThxE6OposHftlRG4rmOTsDsfx+JouHp99LOKqw62h6wEGGQ5pr66O97vrzZycSux
 8tTYy+QwmqOIdSQ42z70Y9BQcmga+swj+G+ceWqvst/BLwaYfSwRD199P+/DefC8rAfwq0
 jolL67Ur7upeRO0A==

> I assume it's sunxi_mmc_oclk_onoff() that is being called and it's the
> loop in there that times out. The question is then, under what
> circumstances are sunxi_mmc_oclk_onoff() being called when we are also
> waiting for the SDIO card to release the busy indication on DAT0?

Yes. It's the first update after probe, from the MMC_POWER_UP set_ios:
  sunxi_mmc_oclk_onoff+0x17c/0x1a0
  sunxi_mmc_clk_set_rate+0x1c/0x2c8
  sunxi_mmc_set_ios+0xe4/0x144
  mmc_power_up.part.0+0x40/0x150
  mmc_start_host+0x90/0x9c
  mmc_add_host+0x6c/0xa0
  sunxi_mmc_probe+0x35c/0x478

STAS already reads 0x206 there, before anything has been sent to the
card; on good boots it's 0x106. So the card is holding DAT0 when Linux
takes over. These are warm boots from the vendor firmware and it
happens on roughly half of them.

The supply explanation in the commit message is wrong, sorry. The rails
are up ~20 ms later and the command is still pending at the 750 ms
timeout. =46rom then on every update times out until the controller is
reset. Rebinding with the card idle never hit it (0/20 tries).
I'll fix the commit message in v4.

Tam


> On Oct 30, 2026, at 8:48=E2=80=AFAM, Ulf Hansson =
<ulf.hansson@oss.qualcomm.com> wrote:
>=20
> On Wed, Oct 28, 2026 at 12:43=E2=80=AFPM Tam Do =
<tam.do@manyhobbies.com> wrote:
>>=20
>> If the clock-update command times out it stays pending in the
>> controller, and every later clock update times out as well, so the
>> card cannot be initialised until the next probe.
>>=20
>> This happens on an R16 board whose SDIO Wi-Fi holds DAT0 busy while
>> its supply comes up during the first clock update.
>=20
> It would be nice if you could elaborate a bit more on what goes on =
here.
>=20
> I assume it's sunxi_mmc_oclk_onoff() that is being called and it's the
> loop in there that times out. The question is then, under what
> circumstances are sunxi_mmc_oclk_onoff() being called when we are also
> waiting for the SDIO card to release the busy indication on DAT0?
>=20
>>=20
>> Reset the controller on timeout so the next attempt can succeed. This
>> runs sunxi_mmc_init_host() with the interrupt enabled for the first
>> time, so write REG_IMASK from sdio_imask under host->lock, as
>> sunxi_mmc_enable_sdio_irq() updates both under that lock.
>>=20
>> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found =
on Allwinner sunxi SoCs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tam Do <tam.do@manyhobbies.com>
>=20
> Kind regards
> Uffe
>=20
>> ---
>> v3: take host->lock only around the REG_IMASK write in
>>    sunxi_mmc_init_host(), not across the reset; v2 polled the reset =
on
>>    jiffies with interrupts off. The return value stays unchecked, as =
in
>>    sunxi_mmc_runtime_resume(): if the reset itself times out the
>>    controller is wedged either way.
>> v2: held host->lock across the reset (not posted)
>> v1: =
https://lore.kernel.org/all/179307312104.39863.12372814163472848752@manyho=
bbies.com/
>>=20
>> drivers/mmc/host/sunxi-mmc.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/mmc/host/sunxi-mmc.c =
b/drivers/mmc/host/sunxi-mmc.c
>> index fe4c0f6d73f3..55313780d06d 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -322,6 +322,7 @@ static int sunxi_mmc_reset_host(struct =
sunxi_mmc_host *host)
>>=20
>> static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
>> {
>> +       unsigned long flags;
>>        u32 rval;
>>=20
>>        if (sunxi_mmc_reset_host(host))
>> @@ -336,7 +337,9 @@ static int sunxi_mmc_init_host(struct =
sunxi_mmc_host *host)
>>        /* Maximum timeout value */
>>        mmc_writel(host, REG_TMOUT, 0xffffffff);
>>        /* Unmask SDIO interrupt if needed */
>> +       spin_lock_irqsave(&host->lock, flags);
>>        mmc_writel(host, REG_IMASK, host->sdio_imask);
>> +       spin_unlock_irqrestore(&host->lock, flags);
>>        /* Clear all pending interrupts */
>>        mmc_writel(host, REG_RINTR, 0xffffffff);
>>        /* Debug register? undocumented */
>> @@ -688,6 +691,7 @@ static int sunxi_mmc_oclk_onoff(struct =
sunxi_mmc_host *host, u32 oclk_en)
>>=20
>>        if (rval & SDXC_START) {
>>                dev_err(mmc_dev(host->mmc), "fatal err update clk =
timeout\n");
>> +               sunxi_mmc_init_host(host);
>>                return -EIO;
>>        }
>>=20
>> --
>> 2.39.5
>>=20

