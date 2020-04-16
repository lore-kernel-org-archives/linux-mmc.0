Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F41C2BA19
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 00:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E43208E0
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 00:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU3jibVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403987AbgDPAaf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:30:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403986AbgDPAab (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 20:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586997028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4rkdFZCt+CYPzp3/Qg70/GCXwWzZ5opTjJmcpHVXJY=;
        b=SU3jibVH2pv07f2gzwNsghrxIE7KEa7LM3LllmhviWV/61yacEjU4ashWG6XxqrnPZy57l
        rHJyBH1j9Ob/y/hiHUblkYJinRt99P6oC7b8ZSfpcMQS/gp3BXf+ydoxuI1JaZIR1JRp4Y
        8yj80gSVlt6kTQSiliOPmdp7uZckBWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-u5im1Xo4PlegAf8ewrePhg-1; Wed, 15 Apr 2020 20:30:25 -0400
X-MC-Unique: u5im1Xo4PlegAf8ewrePhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F9C107ACC9;
        Thu, 16 Apr 2020 00:30:21 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-213.rdu2.redhat.com [10.10.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 041D15DA66;
        Thu, 16 Apr 2020 00:30:09 +0000 (UTC)
Subject: Re: WARNING in kernfs_create_dir_ns
To:     syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, gregkh@linuxfoundation.org, hdanton@sina.com,
        hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, mareklindner@neomailbox.ch,
        mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, ulf.hansson@linaro.org
References: <000000000000ba8e5605a35d4465@google.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <894635f4-772e-a28c-1078-be8a5093e351@redhat.com>
Date:   Wed, 15 Apr 2020 20:30:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000000000000ba8e5605a35d4465@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

