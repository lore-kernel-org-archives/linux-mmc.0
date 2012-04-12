From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 1/2] mmc: Avoid null pointer dereference
Date: Thu, 12 Apr 2012 10:45:25 +0900
Message-ID: <CAKYAXd8Ofmg+kzUgr26CngaNgcw-MXJ91cS4R+BcMLY7yPxjNw@mail.gmail.com>
References: <1334176305-6183-1-git-send-email-philippedeswert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334176305-6183-1-git-send-email-philippedeswert@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe De Swert <philippedeswert@gmail.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, john.calixto@modsystems.com, prakity@marvell.com
List-Id: linux-mmc@vger.kernel.org

2012/4/12 Philippe De Swert <philippedeswert@gmail.com>:
> After the null check on md the code jumped to cmd_done, which then
> will dereference md in mmc_blk_put. This patch avoids the possible
> null pointer dereference in that case.
>
> Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>
This patch is good also.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
