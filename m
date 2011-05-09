From: Vladimir Motyka <vladimir.motyka@gmail.com>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference
 'idata'
Date: Mon, 09 May 2011 17:05:36 +0200
Message-ID: <4DC802C0.9040302@gmail.com>
References: <4DC7F4AB.90607@gmail.com> <Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: cjb@laptop.org, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 05/09/2011 04:32 PM, Julia Lawall wrote:
> On Mon, 9 May 2011, Vladimir Motyka wrote:
> 
>> When allocation of idata fails there was a null dereferece.
> 
> Why not have a different label for the two cases?  That would make the 
> code easier to statically analyze, and perhaps be more understandable as 
> well.
> 
> julia
>
I think You are right. So it could be better like this?

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 3dec493..a03cdc6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -237,7 +237,7 @@ static struct mmc_blk_ioc_data
*mmc_blk_ioctl_copy_from_user(
 	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
 		err = -ENOMEM;
-		goto copy_err;
+		goto alloc_err;
 	}

 	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
@@ -266,9 +266,9 @@ static struct mmc_blk_ioc_data
*mmc_blk_ioctl_copy_from_user(
 	return idata;

 copy_err:
-	if(idata)
-		kfree(idata->buf);
+	kfree(idata->buf);
 	kfree(idata);
+alloc_err:
 	return ERR_PTR(err);
 }

Or it could return right after allocation fails so there needn't be
goto. It is simplier, but maybe worse looking and to read. What is your
opinion?

Vladimir Motyka

> 
>> Signed-off-by: Vladimir Motyka <vladimir.motyka@gmail.com>
>>
>> ---
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 407836d..3dec493 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -266,10 +266,10 @@ static struct mmc_blk_ioc_data
>> *mmc_blk_ioctl_copy_from_user(
>>  	return idata;
>>
>>  copy_err:
>> -	kfree(idata->buf);
>> +	if(idata)
>> +		kfree(idata->buf);
>>  	kfree(idata);
>>  	return ERR_PTR(err);
>> -
>>  }
>>
>>  static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>> --
>> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
