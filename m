From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [stable/4.14.y PATCH 2/3] mmc: Fix null pointer dereference in
 mmc_init_request
Date: Mon, 13 May 2019 22:12:35 +0200
Message-ID: <20190513201235.GB17404@kroah.com>
References: <20190513175521.84955-1-rrangel@chromium.org>
 <20190513175521.84955-3-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513175521.84955-3-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: stable@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 13, 2019 at 11:55:20AM -0600, Raul E Rangel wrote:
> It is possible for queuedata to be cleared in mmc_cleanup_queue before
> the request has been started. This will result in dereferencing a null
> pointer.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/mmc/core/queue.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
