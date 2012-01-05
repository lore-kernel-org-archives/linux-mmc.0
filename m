From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: sdhci max_blk_size
Date: Thu, 5 Jan 2012 13:46:40 +0100
Message-ID: <4F059BB0.6050000@parrot.com>
References: <4F0469B3.9080400@parrot.com> <20120105011634.GA32160@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:48153 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2AEMq4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Jan 2012 07:46:56 -0500
In-Reply-To: <20120105011634.GA32160@ladygaga>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Aaron Lu a =E9crit :
> On Wed, Jan 04, 2012 at 04:01:07PM +0100, Matthieu CASTET wrote:
>> Hi,
>>
>> our controller set "Max Block Length" to 3 (4096 byte), but the linu=
x driver
>> ignore this value [1].
>>
>> Is there any reason to do that .
>=20
> The reason is, sd host controller spec defines 3 as reserved, not 409=
6.
ok, in fact this is an extension of our controller : it claims to be sd=
hci v2,
but they added extra registers and added some field in standard registe=
r.

=46or example they added 4K support by using bit 15 of Block size regis=
ter.

I think we should use SDHCI_QUIRK_FORCE_BLK_SZ_2048.

Sorry for the mail.


Matthieu
