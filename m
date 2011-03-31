From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [comments] MMC: Reliable write support.
Date: Thu, 31 Mar 2011 15:39:39 -0500
Message-ID: <AANLkTimQgeenQNzPK5oFNPj-dGygdJY1S8gXZWdKAZUU@mail.gmail.com>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<201103290901.31680.arnd@arndb.de>
	<AANLkTinDdEJ0bwH3Kj_QmhD=Z=07eaRvpA=sASn+DmkJ@mail.gmail.com>
	<201103301405.21047.arnd@arndb.de>
	<m3mxkc44jm.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:54503 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1CaUjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 16:39:42 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2VKe22I007507
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 16:40:02 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2VKZAVW005471
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 16:40:01 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3169400wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 13:39:39 -0700 (PDT)
In-Reply-To: <m3mxkc44jm.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi Chris,

On Wed, Mar 30, 2011 at 5:38 PM, Chris Ball <cjb@laptop.org> wrote:
> Looks unobjectionable to me, I'd take it with your ACK -- the only
> thought I had was whether it might make sense to add a test to mmc_te=
st
> to check that reliable writes make it out successfully with the same
> data they went in with; it would be awful if there was a data loss bu=
g
> in the code that we didn't catch because we aren't choosing to use
> REQ_FUA/REQ_META.
>
> Then I wondered if there are *other* types of request and data integr=
ity
> that we should be growing mmc_test to handle, and then I was wonderin=
g
> whether this is the realm of mmc_test at all. =A0Any thoughts on that=
? =A0:)

I took a look at mmc_test. It seems like it was meant more to test
cards, rather than block.c functionality, as it issues all MMC
requests by itself, instead of submitting via block layer. It would be
separately an interesting an idea to implement an MMC
reliable write test to mmc_test, but it wouldn't help much with bugs
in block.c. What do you think?

A
