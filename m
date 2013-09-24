From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: Re: [PATCH 2/2] Don't use u8 for fields with more than 1 byte
Date: Mon, 23 Sep 2013 23:25:59 -0400
Message-ID: <CA+5vRUXr_Dt8oPnqGijUso9L5eZSTb7DFdL-F833ajTYi4TZeg@mail.gmail.com>
References: <1379918452-25211-1-git-send-email-oliver@freetz.org>
	<1379918452-25211-2-git-send-email-oliver@freetz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54959 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab3IXD0A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 23:26:00 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq15so3147363wib.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2013 20:26:00 -0700 (PDT)
In-Reply-To: <1379918452-25211-2-git-send-email-oliver@freetz.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oliver Metz <oliver@freetz.org>
Cc: linux-mmc@vger.kernel.org

On Mon, Sep 23, 2013 at 2:40 AM, Oliver Metz <oliver@freetz.org> wrote:
> Signed-off-by: Oliver Metz <oliver@freetz.org>
> ---
>  mmc_cmds.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Looks good to me.

Reviewed-by: Ben Gardiner <ben.l.gardiner@gmail.com>
