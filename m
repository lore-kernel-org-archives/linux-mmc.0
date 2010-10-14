From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH -next] mmc: fix cb710 kconfig dependency warning
Date: Thu, 14 Oct 2010 08:46:42 -0700
Message-ID: <4CB725E2.9020506@oracle.com>
References: <20101013181519.6ff00e10.randy.dunlap@oracle.com> <20101014090442.GA14454@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:18931 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255Ab0JNPrH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2010 11:47:07 -0400
In-Reply-To: <20101014090442.GA14454@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 10/14/10 02:04, Micha=B3 Miros=B3aw wrote:
> On Wed, Oct 13, 2010 at 06:15:19PM -0700, Randy Dunlap wrote:
>> Fix kconfig dependency warning to satisfy dependencies:
>>
>> warning: (MMC_CB710 && MMC && PCI) selects CB710_CORE which has unme=
t direct dependencies (MISC_DEVICES && PCI)
>>
>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>> Cc: <mirq-linux@rere.qmqm.pl>
>> ---
>>  drivers/mmc/host/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20101013.orig/drivers/mmc/host/Kconfig
>> +++ linux-next-20101013/drivers/mmc/host/Kconfig
>> @@ -394,7 +394,7 @@ config MMC_TMIO
>> =20
>>  config MMC_CB710
>>  	tristate "ENE CB710 MMC/SD Interface support"
>> -	depends on PCI
>> +	depends on PCI && MISC_DEVICES
>>  	select CB710_CORE
>>  	help
>>  	  This option enables support for MMC/SD part of ENE CB710/720 Fla=
sh
>=20
> Is this really necessary? MISC_DEVICES is only a submenu enabler, not
> a real dependency.
>=20
> Maybe just select MISC_DEVICES instead? User/developer should not hav=
e
> to know that for this specific MMC controller he has to first enable =
some
> other device burried somewhere in the config tree.

Yes, I'll resubmit using "select".  (like I did with another mmc + mems=
tick patch)

thanks,
--=20
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
