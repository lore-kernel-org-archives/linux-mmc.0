From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
Date: Mon, 11 Apr 2011 15:34:58 -0500
Message-ID: <BANLkTimnmVi6evmXqftCBFkGOKte5sQEdQ@mail.gmail.com>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
	<1302052193-23317-2-git-send-email-andreiw@motorola.com>
	<alpine.DEB.2.00.1104111213230.32082@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:56017 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab1DKUfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 16:35:03 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BKZNY8018535
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 16:35:24 -0400 (EDT)
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BKZMbv018516
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 16:35:23 -0400 (EDT)
Received: by wwk4 with SMTP id 4so3513370wwk.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 13:34:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104111213230.32082@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Mon, Apr 11, 2011 at 2:18 PM, John Calixto
<john.calixto@modsystems.com> wrote:
> Hi Andrei,
>
> On Tue, 5 Apr 2011, Andrei Warkentin wrote:
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 07f27af..a7d7da7 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -92,7 +92,7 @@ struct mmc_command {
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0actively failing requests
>> =A0 */
>>
>> - =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_timeout; =A0/* i=
n milliseconds */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0cmd_timeout; =A0 =A0/*=
 in milliseconds */
>>
>> =A0 =A0 =A0 struct mmc_data =A0 =A0 =A0 =A0 *data; =A0 =A0 =A0 =A0 =A0=
/* data segment associated with cmd */
>> =A0 =A0 =A0 struct mmc_request =A0 =A0 =A0*mrq; =A0 =A0 =A0 =A0 =A0 =
/* associated request */
>
> Could you rename this field to "cmd_timeout_ms"? =A0When I was testin=
g the
> addition of cmd_timeout to my ioctl patch, I noticed that data timeou=
t
> was being specified in ns and I had to scale cmd_timeout appropriatel=
y.
>

Yes! Absolutely. Just sent the updated patch set.

A
