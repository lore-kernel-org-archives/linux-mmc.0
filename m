From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: =?UTF-8?q?=5BPATCH=20414/493=5D=20mmc=3A=20remove=20use=20of=20=5F=5Fdevexit?=
Date: Fri, 23 Nov 2012 00:04:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1211230002530.11581@axis700.grange>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-414-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353349642-3677-414-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: Bruce Chang <brucechang@via.com.tw>, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, spear-devel@list.st.com, linux-mmc@vger.kernel.org, Harald Welte <HaraldWelte@viatech.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Ian Molton <ian@mnementh.co.uk>, Viresh Kumar <viresh.linux@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Manuel Lauss <manuel.lauss@gmail.com>, Pierre Ossman <pierre@ossman.eu>, Chris Ball <cjb@laptop.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

>  drivers/mmc/host/sh_mmcif.c        | 2 +-
>  drivers/mmc/host/tmio_mmc.c        | 2 +-

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
