From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH] drivers: mmc: bfin_sdh: fix build error
Date: Tue, 7 Aug 2012 10:10:29 +0800
Message-ID: <CAA_GA1fbDZpKZ2hTfJ2+adR+yKqdCfRJLeBR+msdU1TbHTGppw@mail.gmail.com>
References: <1343631782-24207-1-git-send-email-lliubbo@gmail.com>
	<CAA_GA1c3w_6Oq7dR+0Exw-warJyL9dr2PKyT6nrkWrDfx=MCKQ@mail.gmail.com>
	<87y5ls11bm.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34015 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab2HGCKa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 22:10:30 -0400
Received: by wibhm11 with SMTP id hm11so2307527wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Aug 2012 19:10:29 -0700 (PDT)
In-Reply-To: <87y5ls11bm.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: adrian.hunter@intel.com, ludovic.desroches@atmel.com, rmk+kernel@arm.linux.org.uk, g.liakhovetski@gmx.de, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, linux-mmc@vger.kernel.org

On Mon, Aug 6, 2012 at 11:34 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Bob,
>
> On Mon, Aug 06 2012, Bob Liu wrote:
>> Would you please take a look at this patch?
>> Since without this patch, regression test for blackfin will fail:
>> http://kisskb.ellerman.id.au/kisskb/matrix/
>
> Thanks, pushed to mmc-next for 3.6 now.
>

Thank you.

> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

-- 
Regards,
--Bob
