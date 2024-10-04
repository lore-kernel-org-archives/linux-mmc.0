Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5F15D1;
	Fri,  4 Oct 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075575; cv=none; b=gBF/AdfbGEYo++ZBqnqM+4EpSgUX7X/KyUwMbrCZoR4ZIEWtx9MfThh5n7rD64WizuI8LmkfEQKr6nRFQOiOhiKnpiEzVwjXEGXz3kybodRaD11sjTrdvQBtjdgWrTj3BEcmyJdIZBhcjma55+5+k4axFScUCCnDKsEvcadFNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075575; c=relaxed/simple;
	bh=/3WqLUyp55MFWyio5AkOs6mN8Dn13D5CQnQY7Az5rxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oxa8LLzjZfNrelUHfBo4XVJL4OBNAsScM9yBzZaPdrFA5Ive4r6tf2fzKmbGJk4a+SLSJ+/O4Godj1NZBAGx0VIJ6pGepi6T1eqKe7aZleczfXATCl/FUMuITmyLivqaf8dLebaRMwJA/SYsGSmes3iIft7Mu85ECmEf8CZI6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BII+msqz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BII+msqz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/3WqLUyp55MFWyio5AkOs6mN8Dn13D5CQnQY7Az5rxg=; b=BII+msqzNxCU2zL5wLSSVvPT/E
	BKsCjmFV6ImfzbP530vw0hwcDEdsguXF5ibc0HcBe+K2tlfD8LnGq7QsYn5pVhiLXWe/1mZ/+pXDv
	pbSqATlBSNRPtMmLpXAZ0O83raw1aeprHObqombUi+R/EmUaYYUCPpyrAHtg8cxi9GqStiAwx1tJY
	UZI+la1C1hrtY4QeqsHfdwlBvG0UOHujGoW1UIkxusd8A1dtDPbeSPO1TNBc9Ba0T1/n40SyeI2SR
	DR1oZl5npe/Zf+Rh/2iqXeYK+YtjwyorVGkzqAYjnO420WZLIZlGTJ14G9TPW/olWaKfgCxCfu83t
	bMY8hc6w==;
Received: from i5e8616d7.versanet.de ([94.134.22.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1swp7o-0003kO-KH; Fri, 04 Oct 2024 22:42:08 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject:
 Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
Date: Fri, 04 Oct 2024 22:42:07 +0200
Message-ID: <1846973.TLkxdtWsSY@diego>
In-Reply-To: <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com>
References:
 <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
 <69d06c04-cc8c-4435-a622-33d5dcd1fa24@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 4. Oktober 2024, 19:34:33 CEST schrieb Robin Murphy:
> On 02/10/2024 10:55 pm, Ulf Hansson wrote:
> > On Sat, 14 Sept 2024 at 13:52, Heiko St=FCbner <heiko@sntech.de> wrote:
> >>
> >> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> >>> In order to make the SD card hotplug working we need the card detect
> >>> function logic inside the controller always working. The runtime PM w=
ill
> >>> gate the clock and the power domain, which stops controller working w=
hen
> >>> no data transfer happen.
> >>>
> >>> So lets skip enable runtime PM when the card needs to detected by the
> >>> controller and the card is removable.
> >>>
> >>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >>
> >> So for the change itself this looks good, i.e. it fixes an issue for b=
aords relying
> >> on the on-chip-card-detect.
> >>
> >>
> >> But for boards doing that, the controller will be running _all the tim=
e_
> >> even if there is never any card inserted.
> >>
> >> So relying on the on-soc card-detect will effectively increase the pow=
er-
> >> consumption of the board - even it it'll never use any sd-card?
> >=20
> > Good point! A better option is to use a polling based mechanism - and
> > we have MMC_CAP_NEEDS_POLL for exactly that.
> >=20
> > Moreover, on DT based platforms one can even use the "broken-cd"
> > property to indicate this.
>=20
> Except that goes further than is needed here, since it would fall back=20
> entirely to software-based polling for card presence. In this case the=20
> CD function is not broken in terms of actually detecting a card, it just=
=20
> doesn't work to wake the controller up from suspend because it can't=20
> fire its own interrupt while powered off. In principle all we should=20
> require here is to periodically resume/suspend the device, to provide a=20
> window for the interrupt to work and normal operation to take over if=20
> appropriate.
>=20
> Of course the really clever way would be for suspend to switch the pin=20
> into GPIO mode, and set the GPIO interrupt as a wakeup to trigger resume=
=20
> and switch it back again, but perhaps that's a bit tricky without=20
> explicit pinctrl states in the DT :/

and then the question really becomes, why move away from cd-gpios at all.


