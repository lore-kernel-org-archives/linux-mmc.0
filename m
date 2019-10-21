From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/7] debugfs: Add debugfs_create_xul() for hexadecimal
 unsigned long
Date: Mon, 21 Oct 2019 08:37:26 -0700
Message-ID: <0f91839d858fcb03435ebc85e61ee4e75371ff37.camel@perches.com>
References: <20191021143742.14487-1-geert+renesas@glider.be>
         <20191021143742.14487-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021143742.14487-2-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 2019-10-21 at 16:37 +0200, Geert Uytterhoeven wrote:
> The existing debugfs_create_ulong() function supports objects of
> type "unsigned long", which are 32-bit or 64-bit depending on the
> platform, in decimal form.  To format objects in hexadecimal, various
> debugfs_create_x*() functions exist, but all of them take fixed-size
> types.
> 
> Add a debugfs helper for "unsigned long" objects in hexadecimal format.
> This avoids the need for users to open-code the same, or introduce
> bugs when casting the value pointer to "u32 *" or "u64 *" to call
> debugfs_create_x{32,64}().
[]
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
[]
> @@ -356,4 +356,14 @@ static inline ssize_t debugfs_write_file_bool(struct file *file,
>  
>  #endif
>  
> +static inline void debugfs_create_xul(const char *name, umode_t mode,
> +				      struct dentry *parent,
> +				      unsigned long *value)
> +{
> +	if (sizeof(*value) == sizeof(u32))
> +		debugfs_create_x32(name, mode, parent, (u32 *)value);
> +	else
> +		debugfs_create_x64(name, mode, parent, (u64 *)value);

trivia: the casts are unnecessary.

This might be more sensible using #ifdef

static inline void debugfs_create_xul(const char *name, umode_t mode,
				      struct dentry *parent,
				      unsigned long *value)
{
#if BITS_PER_LONG == 64
	debugfs_create_x64(name, mode, parent, value);
#else
	debugfs_create_x32(name, mode, parent, value);
#endif
}
