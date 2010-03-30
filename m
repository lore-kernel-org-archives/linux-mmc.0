From: Greg KH <greg@kroah.com>
Subject: Re: [Stable-review] [patch 109/123] s3cmci: initialize default
	platform data no_wprotect and no_detect with 1
Date: Tue, 30 Mar 2010 14:17:58 -0700
Message-ID: <20100330211758.GF15032@kroah.com>
References: <20100313001514.672290530@kvm.kroah.org> <4B9E5D79.6070203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B9E5D79.6070203@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, akpm@linux-foundation.org, torvalds@linux-foundation.org, stable-review@kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 15, 2010 at 05:16:57PM +0100, Stefan Bader wrote:
> This patch does not seem to be applied to 2.6.32.y while the one
> 
> [patch 108/123] s3cmci: s3cmci_card_present: Use no_detect to decide whether
> there is a card detect pin
> 
> is. I checked and the only problem that makes it fail is the uncorrected comment
> above (revised patch attached)

Thanks, now applied.

greg k-h
