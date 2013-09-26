From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] Don't use u8 for fields with more than 1 byte
Date: Wed, 25 Sep 2013 22:26:30 -0400
Message-ID: <877ge42u95.fsf@octavius.laptop.org>
References: <1379918452-25211-1-git-send-email-oliver@freetz.org>
	<1379918452-25211-2-git-send-email-oliver@freetz.org>
	<CA+5vRUXr_Dt8oPnqGijUso9L5eZSTb7DFdL-F833ajTYi4TZeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57473 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab3IZC0e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 22:26:34 -0400
In-Reply-To: <CA+5vRUXr_Dt8oPnqGijUso9L5eZSTb7DFdL-F833ajTYi4TZeg@mail.gmail.com> (Ben
	Gardiner's message of "Mon, 23 Sep 2013 23:25:59 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Gardiner <ben.l.gardiner@gmail.com>
Cc: Oliver Metz <oliver@freetz.org>, linux-mmc@vger.kernel.org

Hi Oliver,

On Mon, Sep 23 2013, Ben Gardiner wrote:
> On Mon, Sep 23, 2013 at 2:40 AM, Oliver Metz <oliver@freetz.org> wrote:
>> Signed-off-by: Oliver Metz <oliver@freetz.org>
>> ---
>>  mmc_cmds.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> Looks good to me.
>
> Reviewed-by: Ben Gardiner <ben.l.gardiner@gmail.com>

Thanks, pushed to mmc-utils with Ben's Reviewed-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
