From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v5] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Sun, 13 Dec 2009 13:29:23 -0800
Message-ID: <6cb013310912131329i139c086av96f0b613647531c0@mail.gmail.com>
References: <1259001448-9574-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1259001448-9574-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 23, 2009 at 10:37 AM, Cory Maccarrone
<darkstar6262@gmail.com> wrote:
> The omap850 and omap730 use 16-bit registers instead of 32-bit, requi=
ring
> a modification of the register addresses in the mmc-omap driver. =C2=A0=
To resolve
> this, a bit shift is performed on base register addresses, either by =
1 or 2
> bits depending on the CPU in use. =C2=A0This yields the correct regis=
ters for
> each CPU.
>
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>

It's been a little while since I've heard anything about this patch.
Is there any chance of it making it in for the current merge window?

Thanks
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
