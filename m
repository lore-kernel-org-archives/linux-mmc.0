From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use module_platform_driver()
Date: Thu, 01 Dec 2011 14:11:00 -0500
Message-ID: <87borsjeez.fsf@laptop.org>
References: <1322283343.14278.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50785 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab1LATKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 14:10:54 -0500
In-Reply-To: <1322283343.14278.2.camel@phoenix> (Axel Lin's message of "Sat,
	26 Nov 2011 12:55:43 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, linux-mmc@vger.kernel.org

Hi Axel, Micha,

On Fri, Nov 25 2011, Axel Lin wrote:
> This patch converts the drivers in drivers/mmc/host/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

This makes cb710_mmc unhappy:

/home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:783:1: warning: data def=
inition has no type or storage class [enabled by default]
/home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:783:1: warning: type def=
aults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98module_platfo=
rm_driver=E2=80=99 [-Wimplicit-int]
/home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:783:1: warning: paramete=
r names (without types) in function declaration [enabled by default]
/home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:773:31: warning: =E2=80=98=
cb710_mmc_driver=E2=80=99 defined but not used [-Wunused-variable]


- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
