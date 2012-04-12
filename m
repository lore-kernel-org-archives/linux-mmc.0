From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 2/2] mmc: Remove dead code
Date: Thu, 12 Apr 2012 10:39:12 +0900
Message-ID: <CAKYAXd8Uor+AM2vf8ZEUsNKef=QbMnExGe47o1m9YMxzQ9ZokQ@mail.gmail.com>
References: <1334176325-6221-1-git-send-email-philippedeswert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57104 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab2DLBjN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 21:39:13 -0400
In-Reply-To: <1334176325-6221-1-git-send-email-philippedeswert@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philippe De Swert <philippedeswert@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, john.calixto@modsystems.com, prakity@marvell.com, cjb@laptop.org

2012/4/12 Philippe De Swert <philippedeswert@gmail.com>:
> bus_width is passed to the function and when 0 (MMC_BUS_WIDTH_1)
> will cause the function to return. So in in the second test it
> definitly is different from 0, and the third test is redundant.
>
> Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>
> ---
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
