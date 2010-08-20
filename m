From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: make dev_to_mmc_card() macro public
Date: Fri, 20 Aug 2010 10:17:20 +0300
Message-ID: <AANLkTi=ktmW4d1VQ2RBnVyJAQkpfRRXzrObkpAY0V0yw@mail.gmail.com>
References: <1282138278-22304-1-git-send-email-ext-andriy.shevchenko@nokia.com>
	<20100819144921.40d6765f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44945 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0HTHRV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 03:17:21 -0400
In-Reply-To: <20100819144921.40d6765f.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org

On Fri, Aug 20, 2010 at 12:49 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> nit: generally, subsystem-specific identifiers should use their
> subsystem's identifier as a prefix. =C2=A0So a better name for
> dev_to_mmc_card() would be mmc_dev_to_card().
Sounds reasonable.
Would you like to get new version of patch or fix against patch?

--=20
With Best Regards,
Andy Shevchenko
