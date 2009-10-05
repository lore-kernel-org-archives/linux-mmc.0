From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH 00/07] sh: SuperH Mobile SDHI changes
Date: Mon, 5 Oct 2009 21:02:30 +0100
Message-ID: <c09aa50a0910051302r768de5av29fde7f1518ee958@mail.gmail.com>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
	<20091005022306.GC3185@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:46777 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbZJEUD1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2009 16:03:27 -0400
In-Reply-To: <20091005022306.GC3185@linux-sh.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, akpm@linux-foundation.org

Im awaiting a reply from the linux-next folk

2009/10/5 Paul Mundt <lethal@linux-sh.org>:
> On Fri, Oct 02, 2009 at 11:21:58AM +0900, Magnus Damm wrote:
>> sh: SuperH Mobile SDHI changes
>>
>> [PATCH 01/07] mfd: Add SuperH Mobile SDHI platform driver
>> [PATCH 02/07] mmc: Add SuperH to the tmio-mmc Kconfig
>> [PATCH 03/07] mmc: Remove const from tmio-mmc platform data
>> [PATCH 04/07] sh: SDHI platform data to the Migo-R board
>> [PATCH 05/07] sh: SDHI platform data to the AP325RXA board
>> [PATCH 06/07] sh: SDHI platform data to the SE7724 board
>> [PATCH 07/07] sh: SDHI platform data to the kfr2r09 board
>>
>> These patches contain the SuperH specific changes needed for
>> the tmio-mmc driver to work with SuperH Mobile SDHI hardware.
>>
>> The tmio-mmc patch 0001-MMC-hardware-abstraction-for-CNF-area.patch
>> by Ian Molton is needed for correct run time behaviour. Without
>> this patch the tmio-mmc probe() fails gracefully.
>>
>> I suggest merging the series in the SuperH tree. Not sure about
>> the best way to merge the patch by Ian.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> At least patch 3/7 depends on Ian's patch being merged first, so there's
> little point in merging this series until that hits upstream. So I'll
> hold off on this for now.
>



-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
