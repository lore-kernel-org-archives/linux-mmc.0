From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: Fixed bug in IDMAC_SET_BUFFER1_SIZE Macro in dw_mmc.c
Date: Fri, 29 Jul 2011 08:53:00 -0400
Message-ID: <m2ei19ckpf.fsf@bob.laptop.org>
References: <1311851023-3563-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E314562.2000001@imgtec.com>
	<CAFbHwiS9ESqXbHF8EnfMaMdR3JNCW+sPEtaAJvL0ptBY1OsFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41137 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756327Ab1G2MxI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jul 2011 08:53:08 -0400
In-Reply-To: <CAFbHwiS9ESqXbHF8EnfMaMdR3JNCW+sPEtaAJvL0ptBY1OsFkQ@mail.gmail.com>
	(Will Newton's message of "Fri, 29 Jul 2011 11:07:09 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Shashidhar,

On Fri, Jul 29 2011, Will Newton wrote:
>>> The mask used inside this macro was assuming Buffer_Size1's[BS1's]
>>> width to be 14 bits,
>>> it is actually of 13 bits, Modified masks used in
>>> IDMAC_SET_BUFFER1_SIZE such that
>>> they use only 13 bits instead of current 14.
>>>
>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>
> Yes, looks correct to me too (for some reason I didn't get the original mail).
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Pushed to mmc-next for 3.1, thanks.

(I didn't get the original mail either; it looks like the mailing lists
rejected it for some reason.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
