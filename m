From: =?ISO-8859-1?Q?Wolfgang_M=FCes?= <wolfgang.mues@auerswald.de>
Subject: Re: [PATCH 1/7] mmc: at91_mci: fix pointer errors
Date: Mon, 30 Aug 2010 08:56:01 +0200
Message-ID: <4C7B5601.5060505@auerswald.de>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com> <20100827193303.GB23079@void.printf.net> <4C7AD3A0.40607@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fw2.winet.de ([84.17.96.48]:59864 "EHLO fw2.winet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0H3H02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 03:26:28 -0400
Received: from mr03.winet.de (localhost [127.0.0.1])
	by fw2.winet.de (Postfix) with ESMTP id 904B8465F21
	for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 08:56:09 +0200 (CEST)
Received: from smtp03.winet.de (mr03.winet.de [192.168.12.13])
	by mr03.winet.de (Postfix) with ESMTP id 7C8CB465F0D
	for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 08:56:09 +0200 (CEST)
Received: from mail.auerswald.de (unknown [212.185.163.229])
	by smtp03.winet.de (Postfix) with ESMTP id 5DDE0465F21
	for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 08:56:09 +0200 (CEST)
In-Reply-To: <4C7AD3A0.40607@bluewatersys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Chris Ball <cjb@laptop.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avictor.za@gmail.com, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Hi,

Am 29.08.2010 23:39, schrieb Ryan Mallon:
> I see this is already applied, but why all the type trickery here? Wh=
y
> not just:
>
> 	memcpy(dmabuf, sgbuffer, amount);
> 	dmabuf +=3D amount / sizeof(dmabuf);

Because this is wrong?

Maybe you mean sizeof(*dmabuf)?

The exact style of the bug fix is not important, it's important that=20
it's fixed.

best regards

i. A. Wolfgang Muees

Hardware-Entwicklung
Leiter Pruefen & Layout
--=20
Auerswald Gesellschaft fuer Datensysteme mbH

Phone: +49 5306-9219-562
=46ax:   +49 5306-9200-94
--------------------------------------------------------------
Auerswald Gesellschaft fuer Datensysteme mbH,
Vor den Grashoefen 1, 38162 Cremlingen

Registriert beim AG Braunschweig HRB 7499
Gesch=E4ftsf=FChrer: Dipl-Ing. Gerhard Auerswald
