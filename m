Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1013D53C;
	Tue,  7 Jul 2026 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410160; cv=none; b=H/eJQ6pLJRfjaez5MB/ClvpHu2cRlhiiV1SklVIrE88xEk1DjD6DbfZHe0HUVElH5lAQe8mPEPhXpKeu6HEPQeHPRFy+cIH5hdVZjLwNlGRUORPGphBDa4JmZVSj1bLc6FtHtc2Yrv5UfhMsoTeS8ezQAttH1VQynz1ka8gfUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410160; c=relaxed/simple;
	bh=pQwyXCyV2PJT4RikPbiEx3IVEGUY43jh3uk9m+jiWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHxl+SLQs2zDkFaijpXVz5MtmVj8IsImW8XMDO1D0amswFkI9fjRU7NkYRBjGjTEsIugWPRHKn9KOET8fNlc8QPO6mZKclm48Tj+kcu1hKc0xGCZovL145jhChjd43tqS3o0vbQY5hqfQOcJkvrdhQtxKI0DyylGs0Ce0UQvZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=K8wqov0F; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="K8wqov0F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=pQwyXCyV2PJT4RikPbiEx3IVEGUY43jh3uk9m+jiWDM=; b=K8wqov0FLWnvSZCw8PWY3vST+K
	Yq8cHvYbn58/ct2vcJKmp1y9CkWhzw6rgoCqmDTWc+cqkFSGrX47X+ezJMe4xtZTUruJyIGS9W0q5
	i05RRBKHlKCWz+9vus3Fl2HdapYqLWXDC5kOJG0f9r2xoB1aHXcs4397brhlqMIPptd3Z59qLFkWB
	Vi4hVN7QnfA5xuhijDTGLLGScZNcuLDatSPa2GxITaJAEclHqxOVsr5Xg5xcH2n/aubDsRvfRErsd
	xWKkAKAvGs/IOSaPIuyXbqjVpuIOd43VNJOGZZnAcq7thzN7sNTtZ02SIv/ARQ/31karQroi7Wf5y
	AN3nsCfQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@nabladev.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Jamie Iles <jamie@jamieiles.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jiri Slaby <jirislaby@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Michael Riesch <michael.riesch@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Yao Zi <ziyao@disroot.org>,
 huang lin <hl@rock-chips.com>, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/12] Add support for the Rockchip RV1106 and RV1103
Date: Tue, 07 Jul 2026 09:41:41 +0200
Message-ID: <7403763.aoefvbuG5b@diego>
In-Reply-To: <882555c4-e1a3-0a0a-6830-b824b93cf3ac@nabladev.com>
References:
 <20260706195818.3906949-1-sjg@chromium.org>
 <882555c4-e1a3-0a0a-6830-b824b93cf3ac@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 7. Juli 2026, 00:54:44 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Fabio Estevam:
> Hi Simon,
>=20
> On Monday, July 06, 2026 16:57 -03, Simon Glass <sjg@chromium.org> wrote:
>=20
> > The series follows the structure of the recently merged RV1103B
> > support. The clock driver is ported from the vendor kernel and is the
>=20
> When I submitted the initial version of the RV1103B series, I received fe=
edback to split it into subsystems.=20
>=20
> You should do the same here and submit it per subsystem:
> ARM, clock, pinctrl, serial, mmc, watchdog, and iio.

correct ... ARM + clock can stay together, as that is my stuff, but for a
lot of maintainer it is just way easier to not have to pick apart series' .
(or even realize they are meant to do something)




