Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE894C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FE064E2E
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhBQIqz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 03:46:55 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:23529 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhBQIqy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 03:46:54 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210217084610epoutp036cbf7a3ad09c53e9e51f3cc8194c8428~kfJrMD5pt1748717487epoutp03f
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 08:46:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210217084610epoutp036cbf7a3ad09c53e9e51f3cc8194c8428~kfJrMD5pt1748717487epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613551570;
        bh=QzQEUPOs0m0/D4bKY3yGwrtaY9o7KDAxLXgD3ubbjOc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=E45TUlJevFAmcx6oW3pQPpdPWY5Er89cEf4LBTElEuE+oBB/OMI7phaxv5Dk+fnLC
         g+TYOKzEaWmWvfjlG5AzFKxPMeC/f01/LI9Gi6Y0QC6bO7ffZZBQa+5Jb0ob1w2CnH
         aK5nB5JQFrT+kLmNQhq2cz3jC1au+qwYKBfJyD8k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210217084610epcas1p20237493d8cf4048e0a989d87f87277c9~kfJqkL4471601616016epcas1p27;
        Wed, 17 Feb 2021 08:46:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DgWdq5Wy1z4x9Q9; Wed, 17 Feb
        2021 08:46:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.84.09577.FC7DC206; Wed, 17 Feb 2021 17:46:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210217084606epcas1p36eaf03e53ac20def83db4c01aeb888d7~kfJnftVlG0091100911epcas1p3V;
        Wed, 17 Feb 2021 08:46:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210217084606epsmtrp16e7c67ac19bf0fc9606395cfabe7bfb2~kfJnestto0764807648epsmtrp1Z;
        Wed, 17 Feb 2021 08:46:06 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-1c-602cd7cf9a2f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.37.13470.EC7DC206; Wed, 17 Feb 2021 17:46:06 +0900 (KST)
Received: from dh0421hwang01 (unknown [10.253.101.58]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210217084606epsmtip166ca59926bece66b09fe33dcc30a91be~kfJnJWGZ52398323983epsmtip1B;
        Wed, 17 Feb 2021 08:46:06 +0000 (GMT)
From:   "DooHyun Hwang" <dh0421.hwang@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <axboe@kernel.dk>, <satyat@google.com>,
        <ebiggers@google.com>, <gustavoars@kernel.org>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <junwoo80.lee@samsung.com>, <jangsub.yi@samsung.com>,
        <sh043.lee@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <3e6525b5-9cd7-e632-800a-1066c5fa3581@intel.com>
Subject: RE: [PATCH 2/2] mmc: core: Add no single read retries
Date:   Wed, 17 Feb 2021 17:46:06 +0900
Message-ID: <000001d70509$54bf59b0$fe3e0d10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKbcqji5gRWP8GQW9gJDYiZCoQNwAIslWD0AVH7PXAC/RaiVwHbTEKIqJBOSmA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPbftbWHrclceO6lz1huHAwdt6QqnG+Bjk9XokKAZZiqlgzvA
        9WVvS5xTw2NWXqEgYW4diyiMGN4pjBUcJhbGQykLIkXHthCCmxuVERB0CMyWyyL/fc/vfL7n
        d77nwWMJ3LiQl6UzUUadWkPi/uyOntCI8Ovje1Ml3zbuQYPTjThquGXF0bkfLRz0Ve8wB400
        nOGg5dUWLloeOctBBZcrMOS4O8RFXav5GBrtqsJR7yMrQJ9193KRteEWjvJWvmcj99AAB/U3
        JaO2n5fYLwqU1XazsubqPUw56jIr7fWFuPKm+yquLG2vB8oF+65E7jFNTCalTqeMIkqXpk/P
        0mXEkq+9qTqokkdJpOFSBYomRTq1loolD72eGB6fpfGGIEXZao3ZW0pU0zQpjosx6s0mSpSp
        p02xJGVI1xikEkMErdbSZl1GRJpeu18qkUTKvWSqJrN7xo0ZOuM/nFlsw3OAExUBPx4k9sHJ
        kTFOEfDnCQgHgGNf9HCZwTyA9vFrXB8lIJYArB6Lf+yo7agEDNQN4KMrlzbsMwBOzLXhPgon
        JLCiz4P7JgIJGwYLXBPr67KIcQAf3v4L81F+RCxsdN1k+3QAEQc9d+q8EI/HJnbDsukUX5lP
        KODSH6s4o7fDwfPT6ziLeB7WfT3DYrYkgg9/r+P4dCCRACeujGIMEwgvFFpYvr6Q+IcHu87k
        4YzhEByeK2UzOgDe72/nMloI71ktG7oYQKszjjGXATjaX7JhlsH5hQXg2yiLCIUtXWKm/Azs
        /PciYBpvg7OLJRwfAgk+LLAIGCQE1qz97UW4Xr0T5m4pA6RtUzDbpmC2TQFs/7eqBux6EEwZ
        aG0GRUsN8s2XbQfrDzxM4QBf/jkX4QQYDzgB5LHIQD53ISxVwE9Xn/qIMupVRrOGop1A7j3p
        cpYwKE3v/SE6k0oqj5TJZGhfVHSUXEbu4B+XTKoERIbaRJ2kKANlfOzDeH7CHKzYY2OH9GR7
        nnPMfvrx5aPLryxryU5Fc0I+P14cLgv+vCpWRB9mPbl9cu3lnpdCa7DRmtBnayqzVMM//XCD
        c7rouwsrWwnzuKXjTp48UqyYsuT2HsjZFVG74/5kVWt1YkrM1vYga/la68Lb8mNv1B490By/
        FHit2XUk9QgnYJCjNc32OW+8867pt8okN5x/z34ixbPH78EHfS7HtvqhSwmH5Unm5LiTwcmO
        aFPZL61Pv7W3OOn22d1bKhTo7vtNU0RL/hP8ujB3snLnr1h2SIL9dKH4oHhiIElY+oKw4Pir
        NPA0tVkGnvqmxJ25/+KKucd/IPf6qRPlvZLwxdx06dSDoE9cJJvOVEvDWEZa/R+3c6NAaQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO656zoJBr2r1SxOPlnDZrH6bj+b
        xYxTbawW84+cY7W4uLqF1eLX3/XsFr8uTmO16Ng6mclix/Mz7Ba7/jYzWVzeNYfN4sj/fkaL
        1r1H2C36V99ls2j6s4/F4tqZE6wWx9eGW2y+9I3FQchjwaZSj8V7XjJ5XD5b6rFpVSebx51r
        e9g8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PXvz+MBZ+cKtr/NLM3MP406WLk5JAQMJFY
        sm0qYxcjF4eQwG5GidU9T5kgEjIS3ff3sncxcgDZwhKHDxdD1LxklPj9rY0ZpIZNwEBi8rE3
        bCAJEYElTBJnLh9nBXGYBe4zSizaNpUdpEpIYDGTxNsuWRCbU8BWYs3ZOywgtrCAncSbZ8vA
        NrAIqEpMeBIHEuYVsJT49uIvG4QtKHFy5hOwcmYBbYmnN5/C2csWvmaGOFRB4ufTZawgtoiA
        n8Tt7ZeZIGpEJGZ3tjFPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5
        xaV56XrJ+bmbGMGxrKW5g3H7qg96hxiZOBgPMUpwMCuJ8LJ/1koQ4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgal+4R6d2xe8mEzqFN5dUXNZ/vn3VanT
        Jr+jmicnzmaO+ztj1nee/CdvdE9cfR7TeWnWrjXrw7PunT6bs8anVnjqVvtJlx7f+Zn+dt3d
        xx4PObrU43nk2CMn6d/SWfWx+mFWj4mS2h/b6mdXTpZIv3VauNCZeTm/bOTb7+ZVz+9c83v4
        wkE3tX11rFTKet741BUJ57UWR4r/dFTavbjudL4cy75T3T9ftGxpNmE+N5Gtb0p7R5LRotL+
        f+3mTx91z0zVX9div0TI/OSsMJbPMnd+CP642/1RvOZ9Wi2D3pyvW3wXnj104/BKP/FstgfM
        El+LJqi9iEn5xr3jUurzN0+T59+Y22a1wFpztURmaLeeEktxRqKhFnNRcSIAV5+MT1QDAAA=
X-CMS-MailID: 20210217084606epcas1p36eaf03e53ac20def83db4c01aeb888d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c
References: <20210217052239.13780-1-dh0421.hwang@samsung.com>
        <CGME20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c@epcas1p2.samsung.com>
        <20210217052239.13780-3-dh0421.hwang@samsung.com>
        <4035139d-7850-8460-f069-06fc61d13039@intel.com>
        <3e6525b5-9cd7-e632-800a-1066c5fa3581@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 17/02/21 8:00 am, Adrian Hunter wrote:
>On 17/02/21 7:46 am, Adrian Hunter wrote:
>> On 17/02/21 7:22 am, DooHyun Hwang wrote:
>>> This makes to handle read errors faster by not retrying multiple
>>> block read(CMD18) errors with single block reads(CMD17).
>>>
>>> On some bad SD Cards that have problem with read operations, it is
>>> not helpful to retry multiple block read errors with several single
>>> block reads, and it is delayed to treat read operations as I/O error
>>> as much as retrying single block reads.
>>
>> If the issue is that it takes too long, then maybe it would be better
>> to get
>> mmc_blk_read_single() to give up after a certain amount of time.
>>
>
>So that a device property would not be needed I mean.  Then everyone would
>benefit.

Thank you for reviewing this.

mmc_blk_read_single() takes a different time depending on the number of
sectors to read and the timeout value for each CMD.

I think it's difficult to set the criteria for =22a certain amount of time=
=22
you talked about.
And it's harder to proceed with any errors caused by giving up in
mmc_blk_read_single() than no retrying.

So, I would like to add a configurable property to skip the single block
read retrying because if multiple block read error occurs, single block
read retrying doesn't help for some bad SD cards.

This is the log to check for this patch.
=230. time difference is about 2.37s for 8 sectors between with(=231) and w=
ithout(=232)
     single block read retrying
     This is a test for just one CMD18.
     When there are many I/O requests, it takes too long to handle the erro=
rs.

=231. retry multiple block read (8 sectors) error with single block reads
// It takes about 3.585671s for the I/O error.
// issue CMD23 (+ arg 0x8)
// issue CMD18 (+ arg 0x000320e0) and error occurs
<7>=5B  316.657115=5D  =5B5:   kworker/5:1H:  324=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  316.657124=5D  =5B5:   kworker/5:1H:  324=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
<7>=5B  316.826302=5D I=5B0:      swapper/0:    0=5D mmc0: req done <CMD23>=
: 0: 00000000 00000000 00000000 00000000
<7>=5B  316.826327=5D I=5B0:      swapper/0:    0=5D mmc0: req done (CMD18)=
: 0: 00000900 00000000 00000000 00000000
<7>=5B  316.826362=5D I=5B0:      swapper/0:    0=5D mmc0:     0 bytes tran=
sferred: -110
<7>=5B  316.826389=5D I=5B0:      swapper/0:    0=5D mmc0:     (CMD12): 0: =
00000b00 00000000 00000000 00000000
<7>=5B  316.826516=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD13 a=
rg 00010000 flags 00000195
<7>=5B  316.826621=5D I=5B0:   kworker/0:1H:  338=5D mmc0: req done (CMD13)=
: 0: 00000900 00000000 00000000 00000000
// retry CMD18 (+ arg 0x000320e0) and error occurs again. Same as above.
<7>=5B  316.829224=5D  =5B5:   kworker/5:1H:  324=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  316.829237=5D  =5B5:   kworker/5:1H:  324=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
<7>=5B  316.999588=5D I=5B0:      swapper/0:    0=5D mmc0: req done <CMD23>=
: 0: 00000000 00000000 00000000 00000000
<7>=5B  316.999653=5D I=5B0:      swapper/0:    0=5D mmc0: req done (CMD18)=
: 0: 00000900 00000000 00000000 00000000
<7>=5B  316.999725=5D I=5B0:      swapper/0:    0=5D mmc0:     0 bytes tran=
sferred: -110
<7>=5B  316.999789=5D I=5B0:      swapper/0:    0=5D mmc0:     (CMD12): 0: =
00000b00 00000000 00000000 00000000
<7>=5B  317.000034=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD13 a=
rg 00010000 flags 00000195
<7>=5B  317.000370=5D I=5B0:   kworker/0:1H:  338=5D mmc0: req done (CMD13)=
: 0: 00000900 00000000 00000000 00000000
// mmc_blk_reset() and it's completed
<7>=5B  317.000523=5D  =5B0:   kworker/0:1H:  338=5D mmc0: clock 0Hz busmod=
e 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
...
// mmc_blk_read_single() : CMD17, CMD13 and CMD12 repeats 8 times (for retr=
ying multiple block read with 8 sectors)
// CMD17 (+ arg 0x000320e0 =7E 0x000320e7) and timeout errors occur
// It takes about 1.351s
<7>=5B  317.200351=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD17 a=
rg 000320e0 flags 000000b5
<7>=5B  317.368748=5D I=5B0:      swapper/0:    0=5D mmc0: req done (CMD17)=
: 0: 00000900 00000000 00000000 00000000
<7>=5B  317.368776=5D I=5B0:      swapper/0:    0=5D mmc0:     0 bytes tran=
sferred: -110
<7>=5B  317.368871=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD13 a=
rg 00010000 flags 00000195
<7>=5B  317.368932=5D I=5B0:   kworker/0:1H:  338=5D mmc0: sdhci: IRQ statu=
s 0x00000001
<7>=5B  317.368970=5D I=5B0:   kworker/0:1H:  338=5D mmc0: req done (CMD13)=
: 0: 00000b00 00000000 00000000 00000000
<7>=5B  317.369020=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD12 a=
rg 00000000 flags 00000095
<7>=5B  317.369070=5D I=5B0:   kworker/0:1H:  338=5D mmc0: sdhci: IRQ statu=
s 0x00000001
<7>=5B  317.369108=5D I=5B0:   kworker/0:1H:  338=5D mmc0: req done (CMD12)=
: 0: 00000b00 00000000 00000000 00000000
<7>=5B  317.369155=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD13 a=
rg 00010000 flags 00000195
<7>=5B  317.369204=5D I=5B0:   kworker/0:1H:  338=5D mmc0: sdhci: IRQ statu=
s 0x00000001
<7>=5B  317.369245=5D I=5B0:   kworker/0:1H:  338=5D mmc0: req done (CMD13)=
: 0: 00000900 00000000 00000000 00000000
<3>=5B  317.369298=5D  =5B0:   kworker/0:1H:  338=5D print_req_error: I/O e=
rror, dev mmcblk0, sector 205024
<7>=5B  317.369342=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD17 a=
rg 000320e1 flags 000000b5
...
<7>=5B  318.382668=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD17 a=
rg 000320e7 flags 000000b5
<3>=5B  318.551568=5D  =5B0:   kworker/0:1H:  338=5D print_req_error: I/O e=
rror, dev mmcblk0, sector 205031
// retry CMD18 (+ arg 0x000320e0) and error occurs again.
<7>=5B  318.551850=5D  =5B5:   kworker/5:1H:  324=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  318.551867=5D  =5B5:   kworker/5:1H:  324=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
...
// retry CMD18 (+ arg 0x000320e0) and error occurs again.
<7>=5B  318.721767=5D  =5B5:   kworker/5:1H:  324=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
// CMD17 (+ arg 0x000320e0 =7E 0x000320e7)
<7>=5B  318.891054=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD17 a=
rg 000320e0 flags 000000b5
...
<7>=5B  320.073861=5D  =5B0:   kworker/0:1H:  338=5D mmc0: starting CMD17 a=
rg 000320e7 flags 000000b5
// Return I/O error for read operation finally
<3>=5B  320.242786=5D  =5B0:   kworker/0:1H:  338=5D Buffer I/O error on de=
v mmcblk0, logical block 25628, async page read

=232. retry multiple block read (8 sectors) error without single block read=
s
// It takes about 1.205941s for the I/O error.
// issue CMD23 (+ arg 0x8)
// issue CMD18 (+ arg 0x000320e0) and error occurs
<7>=5B  126.467114=5D  =5B7:   kworker/7:2H: 8887=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  126.467125=5D  =5B7:   kworker/7:2H: 8887=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
<7>=5B  126.636188=5D I=5B0:Measurement Wor: 9074=5D mmc0: req done <CMD23>=
: 0: 00000000 00000000 00000000 00000000
<7>=5B  126.636213=5D I=5B0:Measurement Wor: 9074=5D mmc0: req done (CMD18)=
: 0: 00000900 00000000 00000000 00000000
<7>=5B  126.636241=5D I=5B0:Measurement Wor: 9074=5D mmc0:     0 bytes tran=
sferred: -110
<7>=5B  126.636265=5D I=5B0:Measurement Wor: 9074=5D mmc0:     (CMD12): 0: =
00000b00 00000000 00000000 00000000
<7>=5B  126.636379=5D  =5B0:   kworker/0:1H:  336=5D mmc0: starting CMD13 a=
rg 00010000 flags 00000195
<7>=5B  126.636495=5D I=5B0:   kworker/0:1H:  336=5D mmc0: req done (CMD13)=
: 0: 00000900 00000000 00000000 00000000
// retry CMD18 (+ arg 0x000320e0) and error occurs again. Same as above.
<7>=5B  126.638284=5D  =5B7:   kworker/7:2H: 8887=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  126.638298=5D  =5B7:   kworker/7:2H: 8887=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
// mmc_blk_reset() and it's completed
<7>=5B  126.807645=5D  =5B0:   kworker/0:1H:  336=5D mmc0: clock 0Hz busmod=
e 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
...
// no mmc_blk_read_single() calling
// retry CMD18 (+ arg 0x000320e0) and error occurs again.
<7>=5B  126.993628=5D  =5B7:   kworker/7:2H: 8887=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  126.993643=5D  =5B7:   kworker/7:2H: 8887=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
// retry CMD18 (+ arg 0x000320e0) and error occurs again.
<7>=5B  127.164836=5D  =5B7:   kworker/7:2H: 8887=5D <mmc0: starting CMD23 =
arg 00000008 flags 00000015>
<7>=5B  127.164848=5D  =5B7:   kworker/7:2H: 8887=5D mmc0: starting CMD18 a=
rg 000320e0 flags 000000b5
...
// Return I/O error for read operation finally
<3>=5B  127.673055=5D I=5B7:      swapper/7:    0=5D Buffer I/O error on de=
v mmcblk0, logical block 25628, async page read


Thank you.

