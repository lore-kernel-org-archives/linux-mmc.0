Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE3C6FD1C
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 15:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjCWPdK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCWPdJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 11:33:09 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E52E2D7B
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 08:33:07 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 75A5A2003B4;
        Thu, 23 Mar 2023 16:33:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1679585584;
        bh=uaDlgi/TgZSzFsUSUtubIyXnyEaCyQg3NdwKMkNPzUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rxXujQ8FCc1EpiGlS9Fa9EMWRwidBB8G71Xyuq67vvbsEHHl4YcJ+KRu2mIeDRn80
         A36yXte7LqcZe0wFk9Hb1wQ9ILtwR0FD2iRk89MdOdRyhdAgdj4gQqiQfTZTHb9L8m
         Pt+KU8I3hKYcMuKXu72fF/WvaNes5isHGHsgfkk4Q33WmVtADUu9LumuaY6YQ1PVf7
         CQkjZ5i4ez7XpFu3My7Im5pvuJUJcSI44ILPUxV38q5i9kj7rhqimUa2NwVf5lQo3e
         8EZE7QTo+f3urOuShVKwGb8OVxnGHYu39l7dTo49u2Tzu8dImKOpBvWV3SUGwIC4DP
         qBTMwK6HazJpA==
Message-ID: <f7539a3d-655f-bdff-977e-ed10becf5d94@free.fr>
Date:   Thu, 23 Mar 2023 16:33:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mmc: core: log empty non-removable slots
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pierre-Hugues Husson <phh@phh.me>, MMC <linux-mmc@vger.kernel.org>
References: <d2444591-c91b-a94d-71e2-9dedc3b6c514@free.fr>
 <CAPDyKFo7z9c9A0ccqBja98WCvp+zJHU2Ni9AZ=UK=fy-nsuKXA@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CAPDyKFo7z9c9A0ccqBja98WCvp+zJHU2Ni9AZ=UK=fy-nsuKXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/03/2023 13:13, Ulf Hansson wrote:

> On Tue, 21 Mar 2023 at 19:01, Marc Gonzalez wrote:
>
>> An empty non-removable slot might be the symptom of probing too early.
> 
> I took the liberty of adjusting the code and the commit message a bit.
> Please let me know if it doesn't look good to you.
> 
> So, applied for next, thanks!

Thanks for reviewing & merging.

Can you tell me (for my knowledge) why it's better to check
host->bus_ops than host->card ?

If the situation should not happen, perhaps we should use pr_warn?

Regards

