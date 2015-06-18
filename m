From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 5/7] samples: kdbus: disable for mn10300
Date: Thu, 18 Jun 2015 07:39:58 -0700
Message-ID: <20150618143958.GA8830@kroah.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434629873-11668-6-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434629873-11668-6-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 18, 2015 at 05:47:51PM +0530, Sudip Mukherjee wrote:
> While building it failed with:
> In function 'prime_new':
> error: '__NR_memfd_create' undeclared (first use in this function)
> 
> memfd_create syscall has not yet been implemented for mn10300.
> so disable compilation of samples/kdbus for now with mn10300.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  samples/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index a4c6b2f..20c55af 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -57,7 +57,7 @@ config SAMPLE_KDB
>  
>  config SAMPLE_KDBUS
>  	bool "Build kdbus API example"
> -	depends on KDBUS
> +	depends on KDBUS && !MN10300

Why not just add the memfd syscall to this arch?  I thought someone had
already sent such a patch in a while ago.

thanks,

greg k-h
