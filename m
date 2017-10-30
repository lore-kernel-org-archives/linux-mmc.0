From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mmc: vub300: Use common code in
 __download_offload_pseudocode()
Date: Mon, 30 Oct 2017 15:15:09 +0300
Message-ID: <20171030121508.zfnsvpsrt25prhr4@mwanda>
References: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
 <CAPDyKFp6h_DAcDvDEMft_WApEakdPQiMw0v8t2fPVxS+H1KkOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp6h_DAcDvDEMft_WApEakdPQiMw0v8t2fPVxS+H1KkOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Tony Olech <tony.olech@elandigitalsystems.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 30, 2017 at 12:40:39PM +0100, Ulf Hansson wrote:
> On 27 October 2017 at 21:31, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Fri, 27 Oct 2017 21:21:40 +0200
> >
> > Add a jump target so that a specific string copy operation is stored
> > only once at the end of this function implementation.
> > Replace two calls of the function "strncpy" by goto statements.
> >
> > This issue was detected by using the Coccinelle software.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Thanks, applied for next!
> 

What's the advantage of this patch?  The new code seems more complicated
to me and GCC automatically reuses duplicate constant strings so there
is no memory savings.

regards,
dan capenter
