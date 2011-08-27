From: Veda N <veda74@gmail.com>
Subject: Re: SDIO
Date: Sat, 27 Aug 2011 14:25:40 +0530
Message-ID: <CAOO8FEekkOxhzmzhyXspCyvQiBFondKcVewj3Cxv+9JVydyt+w@mail.gmail.com>
References: <CAOO8FEeLuJChxugg00paaxK3ra10=pUOxR40JyLA2X55MqB_eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55746 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1H0Izl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Aug 2011 04:55:41 -0400
Received: by vxi9 with SMTP id 9so3205951vxi.19
        for <linux-mmc@vger.kernel.org>; Sat, 27 Aug 2011 01:55:41 -0700 (PDT)
In-Reply-To: <CAOO8FEeLuJChxugg00paaxK3ra10=pUOxR40JyLA2X55MqB_eQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have configured 4 Bit mode in the controller and by setting bit 1 in
the 0x07 address of CCCR in function 0

When i try to read the Vendor id. i dont see the data being sent in
d0-d3. it is sent in d0 only.




On Wed, Aug 17, 2011 at 8:01 PM, Veda N <veda74@gmail.com> wrote:
> To configure the wlan chip into 4 bit mode. What are sequence of
> commands that needs to be done by a host.
>
> Can one explain.
>
> --
> Thanks & Regards,
> S. N. Veda
>



-- 
Regards,
S. N. Veda
