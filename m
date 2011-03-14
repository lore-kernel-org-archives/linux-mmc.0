From: "Richard A. Smith" <richard@laptop.org>
Subject: Re: Memory replacement
Date: Mon, 14 Mar 2011 10:17:34 -0400
Message-ID: <4D7E237E.1040409@laptop.org>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>	<201103122351.07697.arnd@arndb.de>	<AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>	<201103131821.00762.arnd@arndb.de>	<4D7D37C2.2030102@laptop.org> <4D7D4670.1050009@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43777 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1CNORj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 10:17:39 -0400
Received: by vws1 with SMTP id 1so2392841vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2011 07:17:39 -0700 (PDT)
In-Reply-To: <4D7D4670.1050009@bga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mikus@bga.com
Cc: devel@lists.laptop.org, linux-mmc@vger.kernel.org

On 03/13/2011 06:34 PM, Mikus Grinbergs wrote:
>> The tests have also helped expose other issues with things like sudden
>> power off.  In one case a SPO during a write would corrupt the card so
>> badly it became useless.  You could only recover them via a super secret
>> tool from the manufacturer.
>
> Is there any "sledgehammer" process available to users without a super
> secret tool ?

Wasn't just secret to users.  They would not give us the info on how to 
do it either.  It was vendor specific so not really worth the effort of 
trying to reverse engineer.

-- 
Richard A. Smith  <richard@laptop.org>
One Laptop per Child
