From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/8] mmc/core/mmc_test: Improve a size determination in
 five functions
Date: Mon, 9 Jan 2017 19:35:52 +0100
Message-ID: <CACRpkdbo7K0e27WO80H9r7HuKK7oyZ+=eu1wBXE4nrgPwfjZ=w@mail.gmail.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net> <b8461289-1930-08ed-55ef-e2d7dd09a312@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8461289-1930-08ed-55ef-e2d7dd09a312@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Jan 8, 2017 at 10:49 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 21:25:44 +0100
>
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
