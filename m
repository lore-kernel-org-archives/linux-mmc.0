From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Clear the DDR mode for non-DDR
Date: Tue, 3 Jan 2012 10:29:57 +0000
Message-ID: <CAFbHwiSH_eSYofo07Rk4H21nQ+0KSQ8zgmimEZz0anEga8rYgA@mail.gmail.com>
References: <000b01ccc91c$26cf0330$746d0990$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59579 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2ACK36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2012 05:29:58 -0500
In-Reply-To: <000b01ccc91c$26cf0330$746d0990$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org

On Mon, Jan 2, 2012 at 7:00 AM, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> UHS_REG should be cleared for non-DDR mode. But currently there is
> no way to clear DDR mode, if it is already set once. This patch adds
> clearing DDR mode for non-DDD mode.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 11 +++++++----
> =A01 files changed, 7 insertions(+), 4 deletions(-)

Looks ok to me, although I don't have any DDR capable hardware to test.

Acked-by: Will Newton <will.newton@imgtec.com>
