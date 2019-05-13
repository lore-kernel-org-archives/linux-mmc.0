From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [stable/4.14.y PATCH 3/3] mmc: Kill the request if the queuedata
 has been removed
Date: Mon, 13 May 2019 22:12:48 +0200
Message-ID: <20190513201248.GC17404@kroah.com>
References: <20190513175521.84955-1-rrangel@chromium.org>
 <20190513175521.84955-4-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513175521.84955-4-rrangel@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: stable@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 13, 2019 at 11:55:21AM -0600, Raul E Rangel wrote:
> No reason to even try processing the request if the queue is shutting
> down.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/mmc/core/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
