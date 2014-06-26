From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Seeking correct git repo
Date: Thu, 26 Jun 2014 11:35:49 +0200
Message-ID: <cc919527-97e4-46ef-9952-3ceeaea97193@email.android.com>
References: <53AB22F9.40503@webtuner.tv>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57854 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058AbaFZJhD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jun 2014 05:37:03 -0400
Received: by mail-wi0-f174.google.com with SMTP id bs8so666379wib.13
        for <linux-mmc@vger.kernel.org>; Thu, 26 Jun 2014 02:37:02 -0700 (PDT)
In-Reply-To: <53AB22F9.40503@webtuner.tv>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Derek Simkowiak <derek@webtuner.tv>, linux-mmc@vger.kernel.org



On 25 juni 2014 21:28:57 CEST, Derek Simkowiak <derek@webtuner.tv> wrote:
>      Hello,
>A while ago, Romain wrote a small eMMC 5.0 patch that Ulf ack'd:
>
>http://comments.gmane.org/gmane.linux.kernel.mmc/23795
>
>I need this patch for my hardware.  But I don't see this patch in Linux
>
>stable (even though there are more recent patches from Seungwon Jeon in
>
>there), and I don't see it at the MMC repo either:
>
>$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>
># Where's the patch? I checked all branches...
>
>$ git branch -a
>* master
>   remotes/origin/HEAD -> origin/master
>   remotes/origin/master
>   remotes/origin/mmc-next
>   remotes/origin/mmc-updates-for-3.16-rc1-merged
>
>
>Can you please tell me, what is the repo and branch where this patch
>was 
>submitted?  The only reference I have to this patch is the email
>archive 
>at the URL above.

Seems like it was missed. That could happen, then you should either send a ping or resend the patch.

Kind regards
Uffe
>
>
>Thank You,
>Derek
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

