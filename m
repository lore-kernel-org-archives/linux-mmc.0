From: Chris Ball <cjb@laptop.org>
Subject: Re: PATCH:  mmc: sdhci-dove: Fix compile error for 3.3.1
Date: Wed, 04 Apr 2012 12:30:53 -0400
Message-ID: <87ty0za282.fsf@laptop.org>
References: <4F7C738F.20405@i100.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43416 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890Ab2DDQbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Apr 2012 12:31:03 -0400
In-Reply-To: <4F7C738F.20405@i100.no> ("Alf =?utf-8?Q?H=C3=B8gemark=22's?=
 message of "Wed, 04
	Apr 2012 18:15:11 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alf =?utf-8?Q?H=C3=B8gemark?= <alf@i100.no>
Cc: linux-mmc@vger.kernel.org, trivial@kernel.org

Hi Alf,

On Wed, Apr 04 2012, Alf H=C3=B8gemark wrote:
> From: Alf Hogemark <alf <at> i100.no>
>
> This patch fixes a compile error in drivers/mmc/host/sdhci-dove.c by =
including the linux/module.h file.
>
> Signed-off-by: Alf Hogemark <alf <at> i100.no>

Thanks, pushed to mmc-next for 3.4 with a stable@ tag.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
