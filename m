From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/1] of_mmc_spi: fix little endian support
Date: Mon, 30 Jan 2012 08:18:08 -0700
Message-ID: <CACxGe6vY5Es4S_2Q1KWVyHitOuee8XekarGBuxjuJNDbAQrtHA@mail.gmail.com>
References: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com> <20120130131430.GA28397@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49969 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2A3PS2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2012 10:18:28 -0500
Received: by dadi2 with SMTP id i2so3628228dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2012 07:18:28 -0800 (PST)
In-Reply-To: <20120130131430.GA28397@ponder.secretlab.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Mon, Jan 30, 2012 at 6:14 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jan 30, 2012 at 05:15:29AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> the voltage_ranges is supposed to switch from big endian to little endian
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: linux-mmc@vger.kernel.org
>
> Applied, thanks.

Actually, this one should go via Chris' tree since it is part of
drivers/mmc.  So I've dropped it from my tree and change that s-o-b of
mine to an a-b.

g.
