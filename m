From: =?ISO-8859-1?Q?Wolfgang_M=FCes?= <wolfgang.mues@auerswald.de>
Subject: Re: [PATCH 1/7] mmc: at91_mci: fix pointer errors
Date: Mon, 30 Aug 2010 08:51:37 +0200
Message-ID: <4C7B54F9.6090200@auerswald.de>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com> <20100827193303.GB23079@void.printf.net> <20100827193457.GC23079@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fw2.winet.de ([84.17.96.48]:59268 "EHLO fw2.winet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab0H3HJs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 03:09:48 -0400
Received: from mr03.winet.de (localhost [127.0.0.1])
	by fw2.winet.de (Postfix) with ESMTP id 55C64465EBC
	for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 08:51:39 +0200 (CEST)
Received: from smtp03.winet.de (mr03.winet.de [192.168.12.13])
	by mr03.winet.de (Postfix) with ESMTP id 0790A465EF4
	for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 08:51:38 +0200 (CEST)
Received: from mail.auerswald.de (unknown [212.185.163.229])
	by smtp03.winet.de (Postfix) with ESMTP id AE4CA465EBC
	for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 08:51:38 +0200 (CEST)
In-Reply-To: <20100827193457.GC23079@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, avictor.za@gmail.com

Hi,

Am 27.08.2010 21:34, schrieb Chris Ball:
> On Fri, Aug 27, 2010 at 08:33:03PM +0100, Chris Ball wrote:
>> Looks like only the first half of this patch was applied?  The
>> kunmap_atomic() line is still present as before in Linus' tree.

It was argued that the kunmap_atomic() will truncate the pointer to the=
=20
start of the page anyway, so the subtraction is not needed.

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
