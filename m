From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Wed, 4 May 2011 15:01:45 +0200
Message-ID: <201105041501.45796.arnd@arndb.de>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com> <201105032202.42662.arnd@arndb.de> <BANLkTinJxkauY+WUnJet+T5QM4_ROiKzGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59683 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1EDNBv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 09:01:51 -0400
In-Reply-To: <BANLkTinJxkauY+WUnJet+T5QM4_ROiKzGQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On Tuesday 03 May 2011, Per Forlin wrote:
> > submitting small 512 byte read requests is a real problem when the
> > underlying page size is 16 KB. If your interpretation is right,
> > we should probably find a way to make it read larger chunks
> > on flash media.
> Sorry a typo. I missed out a "k" :)
> It reads 512k until 1M.

Ok, much better then.

	Arnd
