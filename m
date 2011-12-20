From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] mmc: omap: remove clock rate hard coding
Date: Tue, 20 Dec 2011 15:17:40 +0530
Message-ID: <CAMQu2gxQZvx9Zyd5n7FHBdZDez9=U14cU5WzZ=WcbjjP7qgYaQ@mail.gmail.com>
References: <1324374120-19920-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57306 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab1LTJsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 20 Dec 2011 04:48:03 -0500
In-Reply-To: <1324374120-19920-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji TK <balajitk@ti.com>

On Tue, Dec 20, 2011 at 3:12 PM, Venkatraman S <svenkatr@ti.com> wrote:
> From: Balaji TK <balajitk@ti.com>
>
> MMC master clock rate can vary for each instance of the MMC controlle=
r
> on the device. Use clk_get_rate instead to get the value.
>
> =A0Signed-off-by: Balaji TK =A0<balajitk@ti.com>
> =A0Reviewed-by: Venkatraman S <svenkatr@ti.com>
> ---
=46inally.
=46eel free to add if you need one
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
