Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214168;
	b=PZH24PHgu0bxVY8i7M64/eE1fvChO7wTNulGBPcPIZx1sXxWY0KeNtRcG1vtJFYTQnNj
	 rx6WXqRk4a0IhE58mcAbDT1QLAE9h73oYCEmll+gh4+1RGHxKAZ/n8WJFxwshwk/IuA9K
	 L8+st9pkZFeD9+tC9/Md37U2+joYo+IvrXwAAJ1Kpj4Jaq+063dLa91IZRY6RHqRzacR3
	 IcdiisWm+/8ezM/k9Z5ihmQHRgQQmURuF9SHj1BGbG4ZY8dHt3ESTbnqNbs2GY51hHKuW
	 t90WRrlTIur1TQJGEAR7knIeQhteukrplXmcshYMxfAqFKK6CcCsNVLCpIIw4mK1aQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214168;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=a4K+nOurooETUPrgB65wShEestuppbBEqKEDo1KslSw=;
	b=rGXtHTvMJr2Fg3P7JIkFFOnk4oU/js87Dvt4lBaUoNSfnRkICFY0O5n7i4+hRo60wLbx
	 tTg873loE8tQz5zLhsIzzqMCHliO6hoeT6Is7gCIgaLej9vOagbBxsOIJjUlJWmjwuI9M
	 9E3UTsUE2gu5LZM+urVmfxWfzWVIi9ioGwTfLc/ClD5Ch3odR+TWNRAC8+/LbwPKukVyI
	 uoAUXnwOA9i4bXAuKC120bkEyUsJ63+iONq5e173ihVQbSfHBop8MNoty2kbM2Yoho3Dj
	 AJ1yBlyQuGxjKZiErRu3INYBuNH4vyoDK5LfKjt8FOoTiVgGCtBrnlBExYY3FCYYEnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=cTYzkQbV;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0F606A32A
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 22:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F0F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=cTYzkQbV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=a4K+
	nOurooETUPrgB65wShEestuppbBEqKEDo1KslSw=; b=cTYzkQbVSYMg4hrEfWkU
	eD8dxG4w4unyCuNJ7VH6BIe0AyTVuwUIePw61VIWOnktcIX6ip52J+x22INWF5mG
	2zjjQK3rDxcrp8xU+UDj5o4RevbbuKSZZ4Zn7zZdTt6kTiXUgyRqSZC9XEdPs0Wo
	jSLdsq578bhIKqZYV/AgkAYlCgUjszQ22A9W6d23d+yidPilegoQgG0GIS3L6K6F
	Z2O/HaRU7/Pp9NdG20D8w0kul8GbzjC18PUwb0LqxoEuokraL9wdO6QWjhlRDxpL
	R53dOZE852VMdDKviPOWuiaj9EA5bhySUOhKkfprVXlLoYjLi+CpEFMMsqLY/buc
	qQ==
Received: (qmail 1634063 invoked from network); 20 Nov 2026 23:36:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Nov 2026 23:36:03 +0100
X-UD-Smtp-Session: l3s3148p1@Jll23rxgIq9tKXA1
Date: Fri, 20 Nov 2026 23:36:02 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pan Chuang <panchuang@vivo.com>,
	Samarth Narang <samarth.colleges@gmail.com>,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH] [v3] mmc: sh_mmcif: rework sg_miter handling
Message-ID: <awDLUtAsAJj-bYdk@shikoro>
References: <20261119152559.3051943-1-arnd@kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119152559.3051943-1-arnd@kernel.org>

Hi Arnd,

> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

I can surely do some testing next week on a Lager-board (HIMEM) and a
Genmai board (non-HIMEM). Dunno how much code review I can provide. I
have never dealt with that part of the driver and my bandwidth to dive
into it is currently rather limited. Let's see what the testing brings.

Have a nice weekend,

   Wolfram

