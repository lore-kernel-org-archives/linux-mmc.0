From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: Add support for pre_req and post_req
Date: Thu, 9 Feb 2012 10:31:23 +0000
Message-ID: <CAFbHwiRq+HqRzDPDy9+WWEa3M4NktW911XVx7ByQJD=qoN-jPA@mail.gmail.com>
References: <000201cce4a4$a5540c20$effc2460$%jun@samsung.com>
	<4F2F8CC7.3010405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52401 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746Ab2BIKbY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 05:31:24 -0500
Received: by pbcun15 with SMTP id un15so1419819pbc.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2012 02:31:23 -0800 (PST)
In-Reply-To: <4F2F8CC7.3010405@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Mon, Feb 6, 2012 at 8:18 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Looks good to me..
>
> Acked-by : Jaehoon Chung <jh80.chung@samsung.com>
>
> On 02/06/2012 04:55 PM, Seungwon Jeon wrote:
>
>> This patch implements pre_req and post_req in dw_mmc
>> to support asynchronous mmc request.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Looks ok to me too.

Acked-by: Will Newton <will.newton@imgtec.com>
