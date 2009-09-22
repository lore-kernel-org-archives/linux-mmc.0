From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 3/3] Move MMCI header to amba include dir
Date: Tue, 22 Sep 2009 15:45:47 +0200
Message-ID: <63386a3d0909220645t2f995c4ftf9893e23ac5caf0e@mail.gmail.com>
References: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com>
	 <20090921150103.GB30821@n2100.arm.linux.org.uk>
	 <20090921151107.GC30821@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47378 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZIVNpo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 09:45:44 -0400
Received: by fxm18 with SMTP id 18so810428fxm.17
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2009 06:45:48 -0700 (PDT)
In-Reply-To: <20090921151107.GC30821@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2009/9/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:

>> Not sure what's happened, but this patch appears to conflict with
>> another, resulting in:
>
> It's also meant that 5702/1 has been dropped in addition to 5699/1.
> In future, please ensure that you run a build check on the machines
> which you've modified. =A0Thanks.

My fault for not regression-compiling enough. Learnt a lesson,
hotted my integration scripts with defaultcompiles for Realview,
Integrator and versatile and submitted new versions to the patch
tracker, sorry for the inconvenience.

Yours.
Linus Walleij
