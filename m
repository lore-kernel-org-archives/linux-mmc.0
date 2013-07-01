From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3.4-stable] mmc: block: fix a bug of error handling in
 MMC driver
Date: Mon, 1 Jul 2013 11:42:13 -0700
Message-ID: <20130701184213.GD11648@kroah.com>
References: <1368165727-32125-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
 <1372665385-8993-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372665385-8993-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 01, 2013 at 04:56:25PM +0900, KOBAYASHI Yoshitake wrote:
> Backport for 3.4-stable for the following patch:
>      https://lkml.org/lkml/2013/5/10/20

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
