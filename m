From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/3] lib/crc7: Shift crc7() output left 1 bit
Date: Wed, 14 May 2014 17:37:22 -0700
Message-ID: <53740C42.3000906@zytor.com>
References: <20140511100211.1334.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140511100211.1334.qmail@ns.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Spelvin <linux@horizon.com>, pavel@ucw.cz
Cc: arik@wizery.com, david.gnedt@davizone.at, eliad@wizery.com, jan.nikitenko@gmail.com, laurent.pinchart+renesas@ideasonboard.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, linux-wireless@vger.kernel.org, linville@tuxdriver.com, luca@coelho.fi, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

On 05/11/2014 03:02 AM, George Spelvin wrote:
> From 770aa22e6c9c92027e3e21797192ccabb3e7c70e Mon Sep 17 00:00:00 2001
> From: George Spelvin <linux@horizon.com>
> Date: Sat, 10 May 2014 10:32:57 -0400
> Subject: [PATCH v2 1/3] lib/crc7: Shift crc7() output left 1 bit
> 
> This eliminates a 1-bit left shift in every single caller,
> and makes the inner loop of the CRC computation more efficient.
> 
> Renamed crc7 to crc7_be (big-endian) since the interface changed.
> 
> Also purged #include <linux/crc7.h> from files that don't use it at all.
> 
> Signed-off-by: George Spelvin <linux@horizon.com>

If the whole point of this is to use it for MMC/SD cards, why not just
also subsume the OR 1 and call it crc7_mmc() or something like that.

(Which I'm all for doing... I don't know of any other crc7 users.)

	-hpa
