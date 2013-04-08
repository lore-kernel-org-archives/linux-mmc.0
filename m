From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: core: negotiate ocr during resume
Date: Mon, 8 Apr 2013 06:41:35 +0000 (UTC)
Message-ID: <loom.20130408T082911-988@post.gmane.org>
References: <CADz5_g+V-th0Vpyo72sOOCKUBsZbT2VQCkAXrVFfJBEDbDfF_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52079 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762503Ab3DHHDE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Apr 2013 03:03:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1UP644-0008W8-PD
	for linux-mmc@vger.kernel.org; Mon, 08 Apr 2013 09:00:31 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2013 09:00:28 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2013 09:00:28 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org


Kevin : you didn't handle the special case that the card is changed to =
a
new card during suspended. So the ocr may be different here.

PNN : This case doesn't holds good because even when new card is insert=
ed
during suspend, cd interrupt is generated and mmc_detect_change will be
called and mmc_rescan will be scheduled to begin initialization from th=
e
beginning, where ocr is freshly read from new card (mmc_attach_***) and=
 my
patch will take care to update new ocr in card->ocr.
Although consider an hypothetical situation where within the debounce t=
ime
of cd, suppose resume gets called, it may fail. But fair enough after 2=
00ms,
fresh initialization will begin and card re-inits. So no need to take
special consideration here. Don't you agree?

Kevin : But if the card detect can't wakeup system then the cd interrup=
t may
be discarded if it occurred during system suspended. For example, if
the card detect used slot-gpio and the slot power is off during system
suspended or card used polling for card detect.
So there must be a solution to verify whether a same card after system
resumed. In fact, there have been such method in current code:

in mmc_sd_init_card:
        if (oldcard) {
                if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0)
                        return -ENOENT;
                card =3D oldcard;

So in my patch, I moved mmc_select_voltage after this verification.
Please consider this case.

_PNN_ : I personally haven=E2=80=99t seen any system design where card =
insertion or=20
removal doesn't generate interrupt to resume the system (I may not have=
 seen=20
enough variety of systems)
But suppose assume, mmc_detect_change, for various reasons as you menti=
oned=20
above is not called during card insertion or removal.
Then still =E2=80=9Coldcard=E2=80=9D pointer is valid but old card has =
been replaced with=20
new card. Your patch will still consider old ocr saved of old card. Rig=
ht?
I didn't understand, how does your patch works and takes care of this=20
situation? Please elaborate.

Thanks & Regards,
Prasanna NAVARATNA

