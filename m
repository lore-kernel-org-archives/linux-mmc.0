From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Thu, 28 Oct 2010 17:31:32 +0200
Message-ID: <AANLkTiks+m_LxTBA0tdOJQ9nf+m-ku6Vn0tiPjvOCAcx@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
 <alpine.LFD.2.00.1010271551500.29484@xanadu.home> <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33239 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758784Ab0J1Pby (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 11:31:54 -0400
Received: by gwj21 with SMTP id 21so1303289gwj.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2010 08:31:53 -0700 (PDT)
In-Reply-To: <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Thu, Oct 28, 2010 at 5:11 PM, Kishore Kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> I think card power decision is taken care in the core as per below patch :
> https://patchwork.kernel.org/patch/226631/

Not really, this is a no-brainer patch to propagate error codes back
from those handlers.

No decision taking is going on there.

Only the card driver can decide when the card can be powered off, and
with SDIO, the function drivers are doing this today using runtime PM
API.
