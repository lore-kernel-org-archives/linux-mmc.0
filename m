From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] Serial: Ingenic: Add support for the X1000.
Date: Sat, 12 Oct 2019 09:35:31 +0200
Message-ID: <20191012073531.GA2036970@kroah.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
 <1548695029-11900-2-git-send-email-zhouyanjie@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548695029-11900-2-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhou Yanjie <zhouyanjie@zoho.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org, ulf.hansson@linaro.org, linus.walleij@linaro.org, armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com, malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net, linux-serial@vger.kernel.org, jslaby@suse.com, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-mmc@vger.kernel.org

On Sat, Oct 12, 2019 at 01:13:23PM +0800, Zhou Yanjie wrote:
> Add support for probing the 8250_ingenic driver on the
> X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

<snip>

you seem to have two patches merged into one here, please fix up and
resend.

thanks,

greg k-h
